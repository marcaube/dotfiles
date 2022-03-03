# My dotfiles

This repo contains my dotfiles, terminal configs, a "manifest" of apps that
should be installed on my system and an installation script to make the process
of setting up a new computer as seamless as possible.


## Before installation

If you have a working computer, make sure you first go through this checklist
before reinstalling everything from scratch...

1. commit and push changes/branches to your git repos
1. save/backup all important documents from non-iCloud directories
1. save all your work from apps which aren't synced through iCloud
1. export important data from your local databases
1. update [mackup](https://github.com/lra/mackup) to the latest version and run `mackup backup`


## Installation

```bash
# 1. Update macOS to the latest version with the App Store
sudo softwareupdate -i -a

# 2. Copy your public and private SSH keys to ~/.ssh and make sure they're set to 600
chmod 600 <name_of_the_key>

# 3. Clone this repo to ~/.dotfiles
cd ~; git clone git@github.com:marcaube/dotfiles.git .dotfiles

# 4. Run install.sh to start the installation
cd ~/.dotfiles; ./install; cd -

# 5. Login with your Apple ID, check iCloud Drive and let it sync for a while

# 6. Restore preferences
mackup restore

# 7. Check that homebrew installations are A1
brew doctor

# 8. Restart your computer to finalize the process
shutdown -r now
```


## Update

To pull the latest changes from the repo and update your setup.

```bash
# 1. Move into the dotfiles directory
dotfiles

# 2. Pull the changes from master
git pull

# 3. Reload the configs
reload

# 4. Restore preferences
mackup restore
```


## Tweaking the setup

To add git credentials, custom commands, or private aliases, you should create
a `zsh/extra.zsh` file. This file is going to be picked up by ZSH but ignored
by git. You can use this file to add stuff you don't want to commit to a public
repository.

For example, that's where you could define your `GIT_AUTHOR_NAME` and
`GIT_AUTHOR_EMAIL`.


## Features

- sensible [`macos`](./macos/macos.sh) configs, see [this repo](https://github.com/kevinSuttle/MacOS-Defaults) for more options
- a [`Brewfile`](./macos/Brewfile) with a list of binaries and apps I use all the time, see [the caskroom](https://caskroom.github.io/search) for more
    - binaries are installed with [Homebrew](http://brew.sh/)
    - apps are either installed with Homebrew Cask or [MAS](https://github.com/mas-cli/mas)
- an [`aliases.zsh`](./zsh/aliases.zsh) file with a bunch of useful aliases and functions
    - CLI app launchers
    - encoding and crypto utility functions
    - an `update` alias to update macOS, mac app store apps, Homebrew binaries and Cask apps
    - a `weather` function to get weather reports from [wttr.in](https://github.com/chubin/wttr.in)
    - and much more...
- a [`.zshrc`](./zsh/zshrc) file to tweak my Oh My Zsh setup, see the [docs](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization) for more
- most app settings synced with iCloud via [Mackup](https://github.com/lra/mackup)


## The files

- [`gitconfig`](./git/gitconfig) is my git configurations
- [`gitignore_global`](./git/gitignore_global) is a list of files and extensions that should be globally ignored by git
- [`mackup.cfg`](./macos/mackup.cfg) is the [Mackup](https://github.com/lra/mackup) configuration, to sync app settings using iCloud instead of Dropbox
- [`macos.sh`](./macos/macos.sh)  contains my macOS preferences
- [`zshrc`](./zsh/zshrc)  contains my Oh My ZSH preferences
- [`aliases.zsh`](./zsh/aliases.zsh) defines a list of useful CLI aliases, shortcuts and functions
- [`Brewfile`](./macos/Brewfile) contains the list of binaries (homebrew) and apps (cask and mas) that I want installed on my system
- [`exports.zsh`](./zsh/exports.zsh) contains the `PATH` env variable configs
- `zsh/extra.zsh` is a file ignored by git where you can add your git credentials, custom commands, private aliases, etc.
- [`install`](./install) is the installation script to make this all work "automagically"
- [`config.lua`](./vim/config.lua) contains my [LunarVim](https://www.lunarvim.org/) configs


## Inspired by...

- Mathias Bynens' [dotfiles](https://github.com/mathiasbynens/dotfiles)
- Dries Vints' [dotfiles](https://github.com/driesvints/dotfiles)
- Sourabh Bajaj's [macOS Setup Guide](https://sourabhbajaj.com/mac-setup/)
- [A practical guide to securing macOS](https://github.com/drduh/macOS-Security-and-Privacy-Guide)
