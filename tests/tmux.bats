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
