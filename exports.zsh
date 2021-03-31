# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Make sure coreutils are loaded before system commands
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Local bin directories before anything else
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Load custom commands
# I've disabled this for now because I've got none
# export PATH="$DOTFILES/bin:$PATH"

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=vim
export VISUAL=vim

# Specify my language environment, you can check your configs with `locale`
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.UTF-8

# Opt-out of Homebrew's analytics
export HOMEBREW_NO_ANALYTICS=1

# Prevent Homebrew from following redirects from HTTPS to HTTP
export HOMEBREW_NO_INSECURE_REDIRECT=1

# Abort installation of a cask if no checksum is defined
export HOMEBREW_CASK_OPTS=--require-sha

# Python
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# For psycopg2, see: https://github.com/psycopg/psycopg2/issues/890
export LDFLAGS="-L/usr/local/opt/openssl/lib"
