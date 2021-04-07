#!/usr/bin/env bash
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"
printf "${GREEN}[+] Setting up your Mac...${ENDCOLOR}\n"

# Hide "last login" line when starting a new terminal session
touch $HOME/.hushlogin

command_does_not_exist(){
    ! command -v "$1" > /dev/null
}

# Install macOS Command Line Tools
if command_does_not_exist xcodebuild; then
    printf "${GREEN}[+] Installing XCode Command Line Tools...${ENDCOLOR}\n"
    xcode-select --install
fi

# Check for Homebrew and install if we don't have it
if command_does_not_exist brew; then
    printf "${GREEN}[+] Installing Homebrew...${ENDCOLOR}\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
printf "${GREEN}[+] Updating Homebrew packages...${ENDCOLOR}\n"
brew update > /dev/null

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle > /dev/null
brew bundle > /dev/null

# Install Oh My ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    printf "${GREEN}[+] Installing Oh My ZSH...${ENDCOLOR}\n"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    compaudit | xargs chmod g-w,o-w
fi

# Add Zsh to the list of shells
if ! grep -q $(which zsh) /etc/shells; then
    printf "${GREEN}[+] Setting zsh as the default shell...${ENDCOLOR}\n"
    sudo sh -c 'which zsh >> /etc/shells'

    # Make ZSH the default shell environment
    chsh -s $(which zsh)
fi

# Create my code directory
if [ ! -d "$HOME/Code" ]; then
    mkdir $HOME/Code
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
printf "${GREEN}[+] Installing dotfiles...${ENDCOLOR}\n"
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink my .vimrc and install plugins
printf "${GREEN}[+] Configuring vim...${ENDCOLOR}\n"
if [ -d $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc.bak
    ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
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
printf "${GREEN}[+] Configuring git...${ENDCOLOR}\n"
rm $HOME/.gitconfig
cp $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
printf "${YELLOW}[!] Don't forget to setup your git signing key!${ENDCOLOR}\n"

# Set macOS preferences
# We will run this last because this will reload the shell
while true; do
    printf "${BLUE}[?] Do you wish to overwrite the macOS preferences? [y/n]${ENDCOLOR}\n"
    read yn
    case $yn in
        [Yy]* ) source .macos; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
