#!/usr/bin/env bats

# Symlinks
@test "~/.zshrc is symlinked" {
  [ -L "$HOME/.zshrc" ]
}

@test "~/.gitconfig is symlinked" {
  [ -L "$HOME/.gitconfig" ]
}

@test "~/.config/nvim is symlinked" {
  [ -L "$HOME/.config/nvim" ]
}

@test "~/.tmux.conf is symlinked" {
  [ -L "$HOME/.tmux.conf" ]
}

@test "~/.config/kitty is symlinked" {
  [ -L "$HOME/.config/kitty" ]
}

@test "~/bin scripts are symlinked" {
  [ -L "$HOME/bin/uuid" ]
  [ -L "$HOME/bin/epoch" ]
  [ -L "$HOME/bin/urlencode" ]
}

# Key binaries from Brewfile
@test "neovim is installed" {
  command -v nvim
}

@test "starship is installed" {
  command -v starship
}

@test "zoxide is installed" {
  command -v zoxide
}

@test "ripgrep is installed" {
  command -v rg
}

@test "fzf is installed" {
  command -v fzf
}

@test "lazygit is installed" {
  command -v lazygit
}

@test "atuin is installed" {
  command -v atuin
}

@test "bat is installed" {
  command -v bat
}

@test "eza is installed" {
  command -v eza
}

@test "fd is installed" {
  command -v fd
}

@test "gh is installed" {
  command -v gh
}

@test "tmux is installed" {
  command -v tmux
}

# Git config correctness
@test "git user.name is set" {
  result=$(git config --global user.name)
  [ -n "$result" ]
}

@test "git default branch is main" {
  result=$(git config --global init.defaultBranch)
  [ "$result" = "main" ]
}

@test "git pull.rebase is true" {
  result=$(git config --global pull.rebase)
  [ "$result" = "true" ]
}

# Tool health checks
@test "neovim starts without errors" {
  nvim --headless -c "qa!" 2>/tmp/nvim_test_errors
  run grep -E "^E[0-9]+:" /tmp/nvim_test_errors
  [ "$status" -ne 0 ]
}

@test "tmux config has no syntax errors" {
  run tmux -f "$HOME/.tmux.conf" new-session -d -s bats_test
  [ "$status" -eq 0 ]
  tmux kill-session -t bats_test 2>/dev/null || true
}
