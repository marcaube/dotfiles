# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

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
export EDITOR=nano
export VISUAL=nano

# Specify my language environment, you can check your configs with `locale`
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.UTF-8