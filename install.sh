#!/bin/sh

echo "Setting up your Mac..."

# Hide "last login" line when starting a new terminal session
touch $HOME/.hushlogin

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
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    compaudit | xargs chmod g-w,o-w
fi

# Add Zsh to the list of shells
if ! grep -q $(which zsh) /etc/shells; then
    sudo sh -c 'which zsh >> /etc/shells'

    # Make ZSH the default shell environment
    chsh -s $(which zsh)
fi

# Create my code directory
if [ ! -d "$HOME/Code" ]; then
    mkdir $HOME/Code
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink my .vimrc and install plugins
if [ -d $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc.bak
    ls -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
fi
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2> /dev/null || true
vim +BundleInstall! +qall

# Symlink the Mackup config file to the home directory
if [ ! -f "$HOME/.mackup.cfg" ]; then
    ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg
fi

# Symlink my custom Mackup configs for unsupported applications
# See: https://github.com/lra/mackup/tree/master/doc#add-support-for-an-application-or-any-file-or-directory
if [ ! -d "$HOME/.mackup" ]; then
    ln -s $HOME/.dotfiles/.mackup $HOME/.mackup
fi

# Set my global git configs
rm $HOME/.gitconfig
cp $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
echo "Don't forget to setup your git signing key."

# Set macOS preferences
# We will run this last because this will reload the shell
while true; do
    read -p "Do you wish to overwrite the macOS preferences? [y/n]" yn
    case $yn in
        [Yy]* ) source .macos; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
