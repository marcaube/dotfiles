# Make sure coreutils are loaded before system commands
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Local bin directories before anything else
export PATH="/$DOTFILES/bin:usr/local/bin:/usr/local/sbin:$PATH"

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=nvim
export VISUAL=nvim

# Specify my language environment, you can check your configs with `locale`
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.UTF-8

# Opt-out of Homebrew's analytics
export HOMEBREW_NO_ANALYTICS=1

# Prevent Homebrew from following redirects from HTTPS to HTTP
export HOMEBREW_NO_INSECURE_REDIRECT=1

# Abort installation of a cask if no checksum is defined
export HOMEBREW_CASK_OPTS=--require-sha

# For psycopg2, see: https://github.com/psycopg/psycopg2/issues/890
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

# For OpenSSL and LLVM
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
