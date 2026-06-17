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

@test "catppuccin v2 theme is loaded (palette variables defined)" {
  tmux -L "$TMUX_SOCKET" -f "$HOME/.tmux.conf" new-session -d -s bats_tmux
  result=$(tmux -L "$TMUX_SOCKET" show-option -gv @thm_pink)
  [[ "$result" == "#"* ]]
}
