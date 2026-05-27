#!/usr/bin/env bats

@test "zsh sources .zshrc without errors" {
  run zsh -i -c 'echo ok'
  [ "$status" -eq 0 ]
  [[ "$output" == *"ok"* ]]
}

@test "zsh plugins are installed" {
  [ -d "$DOTFILES/zsh/plugins/zsh-autosuggestions" ]
  [ -d "$DOTFILES/zsh/plugins/zsh-syntax-highlighting" ]
  [ -d "$DOTFILES/zsh/plugins/zsh-completions" ]
}

@test "exports.zsh sources without errors" {
  run zsh -c "source $DOTFILES/zsh/lib/os.zsh && source $DOTFILES/zsh/exports.zsh"
  [ "$status" -eq 0 ]
}

@test "aliases.zsh sources without errors" {
  run zsh -c "source $DOTFILES/zsh/aliases.zsh"
  [ "$status" -eq 0 ]
}

@test "EDITOR is set to nvim" {
  run zsh -c "source $DOTFILES/zsh/lib/os.zsh && source $DOTFILES/zsh/exports.zsh && echo \$EDITOR"
  [ "$status" -eq 0 ]
  [ "$output" = "nvim" ]
}

@test "PATH includes Homebrew coreutils (macOS only)" {
  [ "$(uname -s)" = "Darwin" ] || skip "coreutils gnubin shim is macOS-only"
  run zsh -c "source $DOTFILES/zsh/lib/os.zsh && source $DOTFILES/zsh/exports.zsh && echo \$PATH"
  [ "$status" -eq 0 ]
  [[ "$output" == *"opt/coreutils"* ]]
}
