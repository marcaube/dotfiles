# Edit my zsh configs in Sublime
alias zshconfig="subl ~/.dotfiles/.zshrc"

# Edit my aliases in Sublime
alias aliases="subl ~/.dotfiles/aliases.zsh"

# Edit my extra configs
alias extras="subl ~/.dotfiles/extra.zsh"

# Open the Sublime scratchpad
alias scratchpad='subl ~/Library/Application\ Support/Sublime\ Text\ 3/scratchpad.txt'

# Edit my hosts file in Sublime
alias hosts='sudo subl /etc/hosts'

# Edit my SSH hosts config in Sublime
alias hostconf='subl ~/.ssh/config'

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
alias pstorm='open -a /Applications/PhpStorm.app "`pwd`"'

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

# How long until Christmas ?
alias noel='php -r "echo (new DateTime())->diff(new DateTime('\''December 25th'\''), true)->format('\''%y ans, %m mois et %d jours (%a jours)'\'') . PHP_EOL;"'

# For those times when you just don't look busy enough
alias busy='export GREP_COLOR='\''1;32'\''; cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"'

# Display a notification
# (useful when executing time-consuming commands)
alias notify='/usr/bin/osascript -e "display notification \"Finished!\" with title \"Zsh\""'

# Get week number
alias week='date +%V'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Get macOS Software Updates, and update composer, Homebrew, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; mas upgrade; composer self-update; composer global update'

# Check if I've got outdated versions of applications
alias outdated='brew outdated; brew cask outdated; mas outdated;composer global outdated'

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

# MISC
alias holdmybeer=sudo
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias tableflip="echo '(╯°□°）╯︵ ┻━┻' | pbcopy"

# Functions
weather() { curl -4 fr.wttr.in/${1:-quebec} }

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

# Utilities
alias base64encode='php -r "echo base64_encode(trim(fgets(STDIN))) . PHP_EOL;"'
alias base64decode='php -r "echo base64_decode(trim(fgets(STDIN))) . PHP_EOL;"'
alias rot13='php -r "echo str_rot13(trim(fgets(STDIN))) . PHP_EOL;"'
alias urlencode='php -r "echo urlencode(trim(fgets(STDIN))) . PHP_EOL;"'
alias urldecode='php -r "echo urldecode(trim(fgets(STDIN))) . PHP_EOL;"'
alias md5='php -r "echo hash(\"md5\", trim(fgets(STDIN))) . PHP_EOL;"'
alias sha1='php -r "echo hash(\"sha1\", trim(fgets(STDIN))) . PHP_EOL;"'
alias sha256='php -r "echo hash(\"sha256\", trim(fgets(STDIN))) . PHP_EOL;"'
alias sha512='php -r "echo hash(\"sha512\", trim(fgets(STDIN))) . PHP_EOL;"'
alias bcrypt='php -r "echo password_hash(trim(fgets(STDIN)), PASSWORD_BCRYPT) . PHP_EOL;"'
alias strlen='php -r "echo strlen(trim(fgets(STDIN))) . PHP_EOL;"'
