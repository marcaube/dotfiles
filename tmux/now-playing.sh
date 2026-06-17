#!/usr/bin/env bash
#
# Emit the track currently playing in macOS Music as a tmux status segment.
#
# Wired into status-right from tmux.conf. Prints a Catppuccin-Mocha-styled pill
# when Music is playing or paused, and nothing otherwise so the segment simply
# disappears. The `is running` guard means we never launch Music ourselves.

set -euo pipefail

# Catppuccin Mocha palette (matches the @thm_* values the tmux plugin sets).
thm_crust="#11111b"
thm_fg="#cdd6f4"
thm_surface_0="#313244"
thm_surface_2="#585b70"
thm_pink="#f5c2e7"
thm_mantle="#181825" # the status-line background, used for the rounded caps

# Nerd Font glyphs, built from byte escapes so the source stays plain ASCII.
cap_left=$(printf '\356\202\266')   # U+E0B6  rounded leading cap
icon_play=$(printf '\357\200\201')  # U+F001  nf-fa-music
icon_pause=$(printf '\357\201\214') # U+F04C  nf-fa-pause

# Longest "track — artist" string we render before truncating with an ellipsis.
readonly MAX_LEN=50

# Ask Music for its state and current track, but only if it is already running.
# Fields are pipe-separated so titles containing other punctuation survive.
info="$(osascript <<'APPLESCRIPT' 2>/dev/null || true
if application "Music" is running then
  tell application "Music"
    try
      set playerState to player state as text
      if playerState is "playing" or playerState is "paused" then
        return playerState & "|" & (name of current track) & "|" & (artist of current track)
      end if
    end try
  end tell
end if
return ""
APPLESCRIPT
)"

[ -n "$info" ] || exit 0

state="${info%%|*}"
rest="${info#*|}"
track="${rest%%|*}"
artist="${rest#*|}"

label="$track"
[ -n "$artist" ] && label="$track — $artist"

# Truncate long titles so the status line never overflows.
if [ "${#label}" -gt "$MAX_LEN" ]; then
  label="${label:0:$((MAX_LEN - 1))}…"
fi

if [ "$state" = "playing" ]; then
  icon="$icon_play"
  icon_bg="$thm_pink"
else
  icon="$icon_pause"
  icon_bg="$thm_surface_2"
fi

# Left-capped pill matching the window/session segments: a rounded leading cap
# over the bar background, a tight icon on the accent colour, then the text on
# the surface colour. Flat right edge (no trailing cap).
printf '#[fg=%s,bg=%s]%s#[fg=%s,bg=%s]%s #[fg=%s,bg=%s] %s ' \
  "$icon_bg" "$thm_mantle" "$cap_left" \
  "$thm_crust" "$icon_bg" "$icon" \
  "$thm_fg" "$thm_surface_0" "$label"
