#!/usr/bin/env bats

# Cross-platform / OS-conditional behaviour.

@test "os.zsh detects the running platform" {
  run zsh -c "source $DOTFILES/zsh/lib/os.zsh && echo \$OS"
  [ "$status" -eq 0 ]
  case "$(uname -s)" in
    Darwin) [ "$output" = "darwin" ] ;;
    Linux)  [ "$output" = "linux" ] ;;
  esac
}

@test "is_macos / is_linux agree with uname" {
  if [ "$(uname -s)" = "Darwin" ]; then
    run zsh -c "source $DOTFILES/zsh/lib/os.zsh && is_macos && ! is_linux"
  else
    run zsh -c "source $DOTFILES/zsh/lib/os.zsh && is_linux && ! is_macos"
  fi
  [ "$status" -eq 0 ]
}

@test "OS-specific aliases file sources without errors" {
  os_file="$DOTFILES/zsh/aliases.$(zsh -c "source $DOTFILES/zsh/lib/os.zsh && echo \$OS").zsh"
  [ -f "$os_file" ] || skip "no OS-specific aliases file for this platform"
  run zsh -c "source $DOTFILES/zsh/lib/os.zsh && source $os_file"
  [ "$status" -eq 0 ]
}

@test "lazygit config is symlinked to the right place for this OS" {
  if [ "$(uname -s)" = "Darwin" ]; then
    [ -L "$HOME/Library/Application Support/lazygit/config.yml" ]
  else
    [ -L "$HOME/.config/lazygit/config.yml" ]
  fi
}

@test "Homebrew is on PATH after an interactive shell loads" {
  run zsh -i -c 'command -v brew'
  [ "$status" -eq 0 ]
}

@test "clipboard helper is available (Linux uses a shim)" {
  if [ "$(uname -s)" = "Darwin" ]; then
    command -v pbcopy
  else
    # On Linux pbcopy is defined as a function in aliases.linux.zsh when a
    # backend (wl-copy / xclip) is present.
    run zsh -i -c 'whence -w pbcopy || command -v wl-copy || command -v xclip'
    [ "$status" -eq 0 ]
  fi
}
