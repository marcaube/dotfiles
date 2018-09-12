# Edit my zsh configs in Sublime
alias zshconfig="subl ~/.dotfiles/.zshrc"

# Edit my aliases in Sublime
alias aliases="subl ~/.dotfiles/aliases.zsh"

# Open the Sublime scratchpad
alias scratchpad='subl ~/Library/Application\ Support/Sublime\ Text\ 3/scratchpad.txt'

# Edit my hosts file in Sublime
alias hosts='sudo subl /etc/hosts'

# Edit my SSH hosts config in Sublime
alias hostconf='subl ~/.ssh/config'

# Reload my CLI configs
alias reload="source ~/.zshrc"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias www='cd ~/Code;pwd'
alias code="cd ~/Code;pwd"
alias dl='cd ~/Downloads'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/;pwd'
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"

# Applications
alias chromeopen='/usr/bin/open -a "/Applications/Google Chrome.app"'
alias pstorm='open -a /Applications/PhpStorm.app "`pwd`"'

# Show/hide hidden files in Finder
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"

# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill='ps ux | grep '\''[C]hrome Helper --type=renderer'\'' | grep -v extension-process | tr -s '\'' '\'' | cut -d '\'' '\'' -f2 | xargs kill'

# How long until Christmas ?
alias noel='php -r "echo (new DateTime())->diff(new DateTime('\''December 25th'\''), true)->format('\''%y ans, %m mois et %d jours (%a jours)'\'') . PHP_EOL;"'

# For those times when you just don't look busy enough
alias busy='export GREP_COLOR='\''1;32'\''; cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"'

# Display a notification
# (useful when executing time-consuming commands)
alias notify='/usr/bin/osascript -e "display notification \"Finished!\" with title \"Zsh\""'

# Flush Directory Service (DNS) cache
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# Get week number
alias week='date +%V'

# MISC
weather() { curl -4 wttr.in/${1:-quebec} }
alias holdmybeer=sudo
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias update='brew update; brew upgrade; brew cleanup; brew cask cleanup; composer self-update; php-cs-fixer self-update; composer global update'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips='ifconfig -a | grep -o '\''inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)'\'' | awk '\''{ sub(/inet6? (addr:)? ?/, ""); print }'\'''
alias localip='ipconfig getifaddr en0'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

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
