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
rm -f $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
source $HOME/.zshrc


# Install zsh plugins
printf "${GREEN}[+] Installing zsh plugins...${ENDCOLOR}\n"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions 2> /dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2> /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2> /dev/null

# Install LunarVim
if [ ! -f "$HOME/.config/nvim/config.lua" ]; then
    printf "${GREEN}[+] Installing LunarVim...${ENDCOLOR}\n"
    sh -c "$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"
    rm -f $HOME/.config/lvim/config.lua
    ln -s $HOME/.dotfiles/config.lua $HOME/.config/lvim/config.lua
fi

# Install my kitty.conf
if [ ! -f "$HOME/.config/kitty/kitty.conf" ]; then
    ln -s $HOME/.dotfiles/kitty.conf $HOME/.config/kitty/kitty.conf
fi

# Install my tmux.conf and plugins
if [ ! -f "$HOME/.tmux.conf" ]; then
    rm -f $HOME/.tmux.conf
    ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf

    # Install tpm to manage tmux plugins (check keybindings: https://github.com/tmux-plugins/tpm#key-bindings)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # Reload the tmux config in the current shell
    tmux source $HOME/.tmux.conf
fi

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
