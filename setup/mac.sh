#!/usr/bin/env sh

# first step is to get git setup and pull the chezmoi repo

source env

declare xcode_select_installed=`xcode-select --install 2>&1 | grep "command line tools are already installed"`
if [ -z "$xcode_select_installed" ]; then
  echo "Installing xcode-select"
  xcode-select --install
else
  echo "xcode-select installed"
fi

# homebrew is probably already installed, but we'll do this anyways...
if [ ! -x /usr/local/bin/brew ]; then
    echo "installing homebrew"
    /usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "homebrew is installed"
fi

# if [ ! -x /usr/local/bin/ansible ]; then
#     echo "installing ansible via homebrew"
#     brew install ansible
# else
#     echo "ansible is installed"
# fi




# mac settings
echo "setting custom mac settings"
# assume we are in the correct directory...
# source ./mac_settings.sh

echo "brewing..."
# assume we are in the correct directory...
brew bundle

# echo "fzf install..."
# $(brew --prefix)/opt/fzf/install

echo "Ready to go!"

