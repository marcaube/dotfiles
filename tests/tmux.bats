#!/usr/bin/env bats

# Use an isolated tmux socket so tests never touch the user's running server.
TMUX_SOCKET="bats_test"

setup() {
  tmux -L "$TMUX_SOCKET" kill-server 2>/dev/null || true
}

teardown() {
  tmux -L "$TMUX_SOCKET" kill-server 2>/dev/null || true
}

@test "tpm plugin manager is installed" {
  [ -d "$HOME/.tmux/plugins/tpm" ]
}

@test "tmux base-index is 1" {
  tmux -L "$TMUX_SOCKET" -f "$HOME/.tmux.conf" new-session -d -s bats_tmux
  result=$(tmux -L "$TMUX_SOCKET" show-option -g base-index)
  [[ "$result" == *"1"* ]]
}

@test "tmux prefix is C-a" {
  tmux -L "$TMUX_SOCKET" -f "$HOME/.tmux.conf" new-session -d -s bats_tmux
  result=$(tmux -L "$TMUX_SOCKET" show-option -g prefix)
  [[ "$result" == *"C-a"* ]]
}

@test "now-playing script is installed and executable" {
  [ -x "$HOME/.tmux/now-playing.sh" ]
}

@test "now-playing segment is prepended to status-right" {
  tmux -L "$TMUX_SOCKET" -f "$HOME/.tmux.conf" new-session -d -s bats_tmux
  result=$(tmux -L "$TMUX_SOCKET" show-option -g status-right)
  [[ "$result" == *"now-playing.sh"* ]]
  # It must come before the window (#W) and session (#S) segments.
  [[ "${result%%now-playing.sh*}" != *"#W"* ]]
}

@test "now-playing script exits cleanly" {
  run "$HOME/.tmux/now-playing.sh"
  [ "$status" -eq 0 ]
}

@test "next-meeting script is installed and executable" {
  [ -x "$HOME/.tmux/next-meeting.sh" ]
}

@test "next-meeting segment is prepended to status-right" {
  tmux -L "$TMUX_SOCKET" -f "$HOME/.tmux.conf" new-session -d -s bats_tmux
  result=$(tmux -L "$TMUX_SOCKET" show-option -g status-right)
  [[ "$result" == *"next-meeting.sh"* ]]
  # It must come before the now-playing, window (#W) and session (#S) segments.
  [[ "${result%%next-meeting.sh*}" != *"now-playing.sh"* ]]
  [[ "${result%%next-meeting.sh*}" != *"#W"* ]]
}

@test "next-meeting script exits cleanly" {
  # Seed a fresh (empty) cache and stamp so the script renders the "nothing to
  # show" path and returns immediately, instead of spawning the slow,
  # permission-gated background Calendar query mid-test.
  : > "${TMPDIR:-/tmp}/tmux-next-meeting.cache"
  date +%s > "${TMPDIR:-/tmp}/tmux-next-meeting.stamp"
  run "$HOME/.tmux/next-meeting.sh"
  [ "$status" -eq 0 ]
}

@test "catppuccin v2 theme is loaded (palette variables defined)" {
  tmux -L "$TMUX_SOCKET" -f "$HOME/.tmux.conf" new-session -d -s bats_tmux
  result=$(tmux -L "$TMUX_SOCKET" show-option -gv @thm_pink)
  [[ "$result" == "#"* ]]
}
