#!/usr/bin/env bash
#
# Emit today's next Calendar event as a tmux status segment.
#
# Wired into status-right from tmux.conf, alongside now-playing.sh. Prints a
# Catppuccin-Mocha-styled pill for the meeting in progress, switching to the
# next one once it is within ten minutes of starting (so back-to-back meetings
# hand off cleanly), and nothing once the day is clear so the segment simply
# disappears.
#
# Data comes from icalBuddy (brew 'ical-buddy'), which reads the Calendar store
# directly and returns in well under a second — unlike AppleScript against
# Calendar.app, which routinely takes tens of seconds. Even so we keep a tiny
# cache: tmux runs status-right commands synchronously every status-interval
# (5s), so rendering from a cache and refreshing in the *background* guarantees
# the status line never stalls, even on a cold Calendar sync. The relative time
# and warning colour are recomputed on every render (cheap), so the pill counts
# down smoothly between the slower cache refreshes.
#
# icalBuddy needs permission to read the calendar database. The first run may
# prompt, or you may need to grant the terminal Calendar access under System
# Settings -> Privacy & Security. Until then the query returns nothing and the
# segment stays hidden.

set -euo pipefail

# Catppuccin Mocha palette (matches the @thm_* values the tmux plugin sets).
thm_crust="#11111b"
thm_fg="#cdd6f4"
thm_surface_0="#313244"
thm_mantle="#181825" # the status-line background, used for the rounded caps
thm_blue="#89b4fa"   # calm: event is comfortably ahead
thm_yellow="#f9e2af" # warning: starts within 15 minutes
thm_red="#f38ba8"    # urgent: starts within 5 minutes, or in progress now

# Nerd Font glyphs, built from byte escapes so the source stays plain ASCII.
cap_left=$(printf '\356\202\266')      # U+E0B6  rounded leading cap
icon_calendar=$(printf '\357\201\263') # U+F073  nf-fa-calendar

# Longest "when — title" string we render before truncating with an ellipsis.
readonly MAX_LEN=44

# Cache holds "start_epoch|end_epoch|title" (or is empty when nothing is left
# today). The stamp file gates how often we kick off a background refresh.
cache="${TMPDIR:-/tmp}/tmux-next-meeting.cache"
stamp="${TMPDIR:-/tmp}/tmux-next-meeting.stamp"
readonly TTL=60

# How long before its start an upcoming meeting takes over the segment from a
# meeting currently in progress. Inside this window the heads-up for what's
# next matters more than what you are already in.
readonly LEAD=600 # 10 minutes

# When a meeting in progress has this many minutes or fewer left, count down to
# its end ("8m left") instead of showing a flat "now".
readonly WRAP=10 # minutes

# Use the system date(1): coreutils may shadow `date` with GNU's, which lacks
# the BSD -j/-f/-r flags this script relies on.
readonly DATE=/bin/date

# Resolve icalBuddy explicitly: tmux often runs with a minimal PATH that omits
# Homebrew's bin directories.
icalbuddy="$(command -v icalBuddy 2>/dev/null || true)"
if [ -z "$icalbuddy" ]; then
  for p in /opt/homebrew/bin/icalBuddy /usr/local/bin/icalBuddy; do
    [ -x "$p" ] && icalbuddy="$p" && break
  done
fi

# Ask icalBuddy for today's timed events (all-day excluded), one per line as
# "HH:MM - HH:MM @@ Title", sorted by start time. Walk them in order and cache
# both the event in progress right now and the next one still to start, each
# tagged ("cur" / "nxt") so the render can switch between them by live time.
# The render needs both because the "10 minutes before the next" boundary moves
# between refreshes. An empty cache means there is nothing left to show today.
refresh_cache() {
  local today now raw line dt title start end start_epoch end_epoch
  local cur_line="" nxt_line=""

  if [ -z "$icalbuddy" ]; then
    : > "$cache.tmp" && mv "$cache.tmp" "$cache"
    return
  fi

  today="$("$DATE" +%Y-%m-%d)"
  now="$("$DATE" +%s)"

  # Keep the previous cache if icalBuddy errors: a syncing or briefly-locked
  # calendar store can fail transiently, and clobbering the cache with an empty
  # file would blank the segment for a whole TTL. Only a *successful* query is
  # allowed to replace what we last showed (or clear it, further down).
  if ! raw="$("$icalbuddy" -ea -nc -nrd -b '' -ps '| @@ |' \
      -iep 'datetime,title' -po 'datetime,title' -tf '%H:%M' \
      eventsToday 2>/dev/null)"; then
    return
  fi

  # Events come back sorted by start time, so the first in-progress event is the
  # current meeting and the first not-yet-started one is the next meeting.
  while IFS= read -r line; do
    # Skip blanks and any line that lacks our datetime/title separator (e.g. a
    # multi-day event whose datetime icalBuddy formats differently).
    case "$line" in
      *" @@ "*) ;;
      *) continue ;;
    esac

    dt="${line%% @@ *}"
    title="${line#* @@ }"
    title="${title%"${title##*[![:space:]]}"}" # trim trailing whitespace

    start="${dt%% - *}"
    end="${dt#* - }"
    case "$start" in [0-2][0-9]:[0-5][0-9]) ;; *) continue ;; esac

    start_epoch="$("$DATE" -j -f '%Y-%m-%d %H:%M' "$today $start" +%s 2>/dev/null)" || continue
    case "$end" in
      [0-2][0-9]:[0-5][0-9]) end_epoch="$("$DATE" -j -f '%Y-%m-%d %H:%M' "$today $end" +%s 2>/dev/null)" || end_epoch=$((start_epoch + 3600)) ;;
      *) end_epoch=$((start_epoch + 3600)) ;;
    esac

    if [ "$end_epoch" -le "$now" ]; then
      continue # already over
    elif [ "$start_epoch" -le "$now" ]; then
      [ -z "$cur_line" ] && cur_line="cur|$start_epoch|$end_epoch|$title"
    else
      nxt_line="nxt|$start_epoch|$end_epoch|$title"
      break # sorted: the first upcoming is the next, and nothing after it matters
    fi
  done <<EOF
$raw
EOF

  # Both lines are optional; an empty file means nothing is left today.
  {
    [ -n "$cur_line" ] && printf '%s\n' "$cur_line"
    [ -n "$nxt_line" ] && printf '%s\n' "$nxt_line"
  } > "$cache.tmp"
  mv "$cache.tmp" "$cache"
}

# Stamp the gate first, then refresh detached, so concurrent ticks within the
# TTL don't pile up overlapping queries.
stamp_age=$(( TTL + 1 ))
[ -f "$stamp" ] && stamp_age=$(( $("$DATE" +%s) - $("$DATE" -r "$stamp" +%s) ))
if [ "$stamp_age" -ge "$TTL" ]; then
  "$DATE" +%s > "$stamp"
  ( refresh_cache ) >/dev/null 2>&1 &
fi

# Render from cache. No cache yet (cold start) or an empty one means there is
# nothing to show, so the segment stays hidden until the next refresh lands.
[ -f "$cache" ] || exit 0
cur_start="" cur_end="" cur_title=""
nxt_start="" nxt_end="" nxt_title=""
while IFS='|' read -r tag s e t; do
  case "$tag" in
    cur) cur_start="$s" cur_end="$e" cur_title="$t" ;;
    nxt) nxt_start="$s" nxt_end="$e" nxt_title="$t" ;;
  esac
done < "$cache"

now="$("$DATE" +%s)"

# Roles go stale as time passes: the current meeting ends, or the next one
# starts and ought to become the current. Either way clear the gate so the very
# next tick refreshes (re-deriving roles and pulling in a following meeting)
# instead of waiting out the TTL. This is what makes a back-to-back meeting take
# over within one status interval rather than up to a minute later.
if { [ -n "$cur_end" ] && [ "$now" -ge "$cur_end" ]; } ||
   { [ -n "$nxt_start" ] && [ "$now" -ge "$nxt_start" ]; }; then
  rm -f "$stamp"
fi

# Pick what to show: the next meeting once it is within LEAD of starting (so a
# back-to-back meeting pre-empts the one you are still in), otherwise the
# meeting in progress, otherwise simply the next one.
if [ -n "$nxt_start" ] && [ "$(( nxt_start - now ))" -le "$LEAD" ]; then
  start_epoch="$nxt_start" end_epoch="$nxt_end" title="$nxt_title"
elif [ -n "$cur_end" ] && [ "$now" -lt "$cur_end" ]; then
  start_epoch="$cur_start" end_epoch="$cur_end" title="$cur_title"
elif [ -n "$nxt_start" ]; then
  start_epoch="$nxt_start" end_epoch="$nxt_end" title="$nxt_title"
else
  exit 0
fi

# Guard against a selected event that has already ended (large refresh lag).
[ "$now" -lt "$end_epoch" ] || exit 0

# A meeting in progress stays red and reads "now", switching to a countdown to
# its end ("8m left") over the final WRAP minutes. An upcoming meeting warms
# from blue (clock time) through yellow to red as its start nears.
if [ "$now" -ge "$start_epoch" ]; then
  left=$(( (end_epoch - now + 59) / 60 )) # minutes until it ends, rounded up
  if [ "$left" -le "$WRAP" ]; then
    when="${left}m left"
  else
    when="now"
  fi
  accent="$thm_red"
else
  mins=$(( (start_epoch - now + 59) / 60 )) # minutes until start, rounded up
  if [ "$mins" -le 5 ]; then
    when="in ${mins}m"
    accent="$thm_red"
  elif [ "$mins" -le 15 ]; then
    when="in ${mins}m"
    accent="$thm_yellow"
  else
    when="$("$DATE" -r "$start_epoch" +%H:%M)"
    accent="$thm_blue"
  fi
fi

label="$when — $title"
if [ "${#label}" -gt "$MAX_LEN" ]; then
  label="${label:0:$((MAX_LEN - 1))}…"
fi

# Left-capped pill matching now-playing and the window/session segments: a
# rounded leading cap over the bar background, a tight icon on the accent
# colour, then the text on the surface colour. Flat right edge (no trailing
# cap) so it abuts the next segment cleanly.
printf '#[fg=%s,bg=%s]%s#[fg=%s,bg=%s]%s #[fg=%s,bg=%s] %s ' \
  "$accent" "$thm_mantle" "$cap_left" \
  "$thm_crust" "$accent" "$icon_calendar" \
  "$thm_fg" "$thm_surface_0" "$label"
