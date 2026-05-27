# Resolve Homebrew's prefix per-platform (/opt/homebrew on Apple Silicon,
# /home/linuxbrew/.linuxbrew on Linux) and put its tools on the PATH.
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Make sure coreutils are loaded before system commands (macOS only — Linux
# ships GNU coreutils natively, so no gnubin shim is needed).
if is_macos && [ -d "$(brew --prefix)/opt/coreutils/libexec/gnubin" ]; then
    export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
fi

# Local bin directories before anything else
export PATH="$DOTFILES/bin:/usr/local/bin:/usr/local/sbin:$PATH"

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

# macOS-only build flags for Homebrew-provided OpenSSL/LLVM.
if is_macos; then
    # For psycopg2, see: https://github.com/psycopg/psycopg2/issues/890
    export LDFLAGS="-L$(brew --prefix)/opt/openssl@3/lib"
    export CPPFLAGS="-I$(brew --prefix)/opt/openssl@3/include"

    # For OpenSSL and LLVM
    export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
fi
