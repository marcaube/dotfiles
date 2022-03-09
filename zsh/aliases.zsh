# Edit my zsh configs
alias zshconfig='$EDITOR ~/.dotfiles/.zshrc'

# Edit my aliases
alias aliases='$EDITOR ~/.dotfiles/aliases.zsh'

# Edit my extra configs
alias extras='$EDITOR ~/.dotfiles/extra.zsh'

# Open my local scratchpad
SCRATCHFILE=~/scratchpad.txt
alias scratchpad='echo "\n\n$(date):\n=============================\n" >> $SCRATCHFILE; $EDITOR $SCRATCHFILE'
alias sp='scratchpad'

# Edit my hosts file
alias hosts='sudo $EDITOR /etc/hosts'

# Edit my SSH hosts config
alias hostconf='$EDITOR ~/.ssh/config'

# Reload my CLI configs
alias reload="source ~/.zshrc"

# Restart the computer
alias restart="sudo shutdown -r now"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias code="cd ~/Code;pwd"
alias dl='cd ~/Downloads'
alias dotfiles="cd $DOTFILES"
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/;pwd'
alias library="cd $HOME/Library"
alias www='cd ~/Code;pwd'

# Application launchers
alias cat='bat'
alias woman=tldr # Grace Hopper approved
alias chromeopen='/usr/bin/open -a "/Applications/Google Chrome.app"'

# Show/hide hidden files in Finder
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'

# Show/hide all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"

# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill='ps ux | grep '\''[C]hrome Helper --type=renderer'\'' | grep -v extension-process | tr -s '\'' '\'' | cut -d '\'' '\'' -f2 | xargs kill'

# Kill a runaway docker run command, when your test suite just don't want to finish...
alias dockerrunkill='ps | grep '\''docker run'\'' | grep -v grep | awk '\''{print $1}'\'' | xargs kill -9'

# For those times when you just don't look busy enough
alias busy='export GREP_COLOR='\''1;32'\''; cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"'

# Display a notification
# (useful when executing time-consuming commands)
alias notify='/usr/bin/osascript -e "display notification \"Finished!\" with title \"Zsh\""'

# Get week number
alias week='date +%V'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Get macOS Software Updates, update Homebrew and its installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew upgrade --cask; brew cleanup; mas upgrade;tldr --update'

# Check if I've got outdated versions of applications
alias outdated='brew outdated; mas outdated'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip='ipconfig getifaddr en0'
alias ips='ifconfig -a | grep -o '\''inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)'\'' | awk '\''{ sub(/inet6? (addr:)? ?/, ""); print }'\'''

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service (DNS) cache
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Show how much diskspace I got left (shouldn't have bought that puny 128GB MBA...)
alias diskspace="df -P -kHl"

# Clean-up the temporary/cache files in a Python project
alias pyclean='find . -name "*.py[co]" -o -name __pycache__ -exec rm -rf {} +'

# Clean-up any dependencies that were installed outside a virtual environment
alias pipclean="pip list | awk '{if (NR>2) print $1}' | grep -v pip | grep -v setuptools | xargs pip uninstall -y"
alias pip3clean="pip3 list | awk '{if (NR>2) print $1}' | grep -v pip | grep -v setuptools | xargs pip uninstall -y"

# MISC
alias holdmybeer=sudo
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias tableflip="echo '(╯°□°）╯︵ ┻━┻' | pbcopy"

# Functions
weather() { curl -4 fr.wttr.in/${1:-"quebec city"} }

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* ./*;
    fi;
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-9000}"
    sleep 2 && open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python3 -c "from http.server import test, SimpleHTTPRequestHandler as RH; RH.extensions_map = {k: v + ';charset=UTF-8' for k, v in RH.extensions_map.items()}; test(HandlerClass=RH, port=${port}, bind=None)"
}

# Scrape a single webpage with all assets
function scrapeUrl() {
    wget --adjust-extension --convert-links --page-requisites --span-hosts --no-host-directories "$1"
}

# Shortcut for the OSX quick-look command
function ql() {
   quick-look "$1"
}

# Function to easily match text using regexes in a command pipeline, second param is the capture group number
# e.g. `find . -name '*.py' | xargs cat | regex '^class (\w+)' 1 | sort | uniq` to find all the classes in a Py project
function regex() {
    gawk 'match($0,/'$1'/, ary) {print ary['${2:-'0'}']}';
}

# When you want the length of a string and wc won't do
function length() {
    awk '{print length, $0}'
}

# Git checkout with branch name autocomplete using fzf (from: https://elijahmanor.com/byte/git-recent-branches)
alias cb='git branch --sort=-committerdate | fzf --header Checkout | xargs git checkout'

# Tmux shortcuts (from: https://github.com/everzet/dotfiles/blob/master/zsh/aliases.zsh)
alias tn='tmux new-session -s ${PWD##*/}'
alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tks='tmux kill-session -t'
