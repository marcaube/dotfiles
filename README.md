# My dotfiles

Inspired by...
- Mathias Bynens [dotfiles](https://github.com/mathiasbynens/dotfiles)
- Dries Vints [dotfiles](https://github.com/driesvints/dotfiles)

## Installation

```bash
# 1. Update macOS to the latest version with the App Store
sudo softwareupdate -i -a

# 2. Install macOS Command Line Tools by running xcode-select --install
xcode-select --install

# 3. Copy your public and private SSH keys to ~/.ssh and make sure they're set to 600

# 4. Clone this repo to ~/.dotfiles
cd ~; git clone https://github.com/marcaube/dotfiles.git .dotfiles

# 5. Run install.sh to start the installation
sh .dotfiles/install.sh

# 6. Restore preferences by running mackup restore
mackup restore

# 7. Restart your computer to finalize the process
shutdown -r now
```

## Multi-user setup

1. create a group `brew` and add users in it
1. execute `brew doctor` to check if brew is installed correctly
1. `sudo chgrp -R brew /usr/local` to change the owner of the homebrew install dir
1. `sudo chmod -R g+w /usr/local` to allow write access to group members
1. `sudo chgrp -R brew /Library/Caches/Homebrew` to change the owner of the homebrew cache dir
1. `sudo chmod -R g+w /Library/Caches/Homebrew` to allow write access to group members
1. `brew doctor` to make sure everything is alright
