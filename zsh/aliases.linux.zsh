# Linux-only aliases and functions (Debian/Ubuntu assumed for package commands).
# Sourced by zshrc as aliases.${OS}.zsh when $OS == linux.
#
# Provides pbcopy/pbpaste and `open` shims so the portable aliases in
# aliases.zsh (pubkey, shrug, tableflip, md5, server) work unchanged.

# Clipboard — prefer Wayland's wl-clipboard, fall back to X11's xclip.
if [[ -n "$WAYLAND_DISPLAY" ]] && command -v wl-copy >/dev/null 2>&1; then
    pbcopy()  { wl-copy }
    pbpaste() { wl-paste }
elif command -v xclip >/dev/null 2>&1; then
    pbcopy()  { xclip -selection clipboard }
    pbpaste() { xclip -selection clipboard -o }
fi

# Open files/URLs with the desktop's default handler
if command -v xdg-open >/dev/null 2>&1; then
    alias open='xdg-open'
fi

# Desktop notification (useful when executing time-consuming commands)
if command -v notify-send >/dev/null 2>&1; then
    alias notify='notify-send "Zsh" "Finished!"'
fi

# Update the system and Homebrew packages
alias update='sudo apt update && sudo apt upgrade -y; command -v brew >/dev/null 2>&1 && { brew update; brew upgrade; brew cleanup; }; tldr --update'

# Check for outdated Homebrew packages
alias outdated='command -v brew >/dev/null 2>&1 && brew outdated'

# IP addresses
alias localip="hostname -I | awk '{print \$1}'"
alias ips="ip -o addr show | awk '{print \$2, \$4}'"

# Flush systemd-resolved's DNS cache (no-op if not used)
alias flush='sudo resolvectl flush-caches 2>/dev/null || sudo systemd-resolve --flush-caches 2>/dev/null'

# Quick-look equivalent: open in the default viewer
alias ql='xdg-open'
