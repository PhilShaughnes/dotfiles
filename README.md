# dotfiles

Ahoy! Welcome to the dotfiles!

This will outline basic setup steps to use this.

Currently I only have this setup for MacOS. When I have linux setup, I'll add a section for that.


## Mac

Steps for Mac are:
* install x-code thingy:
```sh
xcode-select --install
```
* install brew:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
* install git and chezmoi:
```sh
brew install git chezmoi

```
* initialize chezmoi
```sh
chezmoi init git@github.com:philshaughes/dotfiles.git
```
