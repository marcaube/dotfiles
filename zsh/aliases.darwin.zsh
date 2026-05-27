# macOS-only aliases and functions.
# Sourced by zshrc as aliases.${OS}.zsh when $OS == macos.
# pbcopy/pbpaste and `open` are macOS built-ins, so the portable aliases in
# aliases.zsh that rely on them work here without a shim.

# Navigation into macOS-specific locations
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/;pwd'
alias library="cd $HOME/Library"

# Launch Google Chrome
alias chromeopen='/usr/bin/open -a "/Applications/Google Chrome.app"'

# Show/hide hidden files in Finder
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'

# Show/hide all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Disable/enable Spotlight
alias spotoff="sudo mdutil -a -i off"
alias spoton="sudo mdutil -a -i on"

# Display a notification (useful when executing time-consuming commands)
alias notify='/usr/bin/osascript -e "display notification \"Finished!\" with title \"Zsh\""'

# Get macOS Software Updates, update Homebrew and its installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew upgrade --cask; brew cleanup; mas upgrade;tldr --update'

# Check if I've got outdated versions of applications
alias outdated='brew outdated; mas outdated'

# IP addresses
alias localip='ipconfig getifaddr en0'
alias ips='ifconfig -a | grep -o '\''inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)'\'' | awk '\''{ sub(/inet6? (addr:)? ?/, ""); print }'\'''

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service (DNS) cache
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# Shortcut for the macOS quick-look command
function ql() {
   quick-look "$1"
}
