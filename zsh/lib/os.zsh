# OS detection — sourced first so everything downstream can branch on platform.
# $OS mirrors the lowercased `uname -s`, matching the install.conf.<os>.yaml and
# aliases.<os>.zsh filenames.
case "$(uname -s)" in
  Darwin) OS=darwin ;;
  Linux)  OS=linux ;;
  *)      OS=unknown ;;
esac
export OS

is_macos() { [[ "$OS" == darwin ]]; }
is_linux() { [[ "$OS" == linux ]]; }
