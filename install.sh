#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install Oh My ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    compaudit | xargs chmod g-w,o-w
fi

# Add Zsh to the list of shells
if ! grep -q $(which zsh) /etc/shells; then
    sudo sh -c 'which zsh >> /etc/shells'

    # Make ZSH the default shell environment
    chsh -s $(which zsh)
fi

# Create my code directory
mkdir $HOME/Code

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set my global git configs
rm $HOME/.gitconfig
cp $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
