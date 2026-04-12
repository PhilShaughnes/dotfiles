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

# if [ ! -x /usr/local/bin/docker ]; then
#   echo "Install Docker for Mac: https://www.docker.com/products/docker#/mac"
#   exit 1
# else
#     echo "Docker is installed"
# fi

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

# # uses rcm - we've switched to chezmoi
# echo "linking dotfiles"
# export RCRC='$DOTFILES/rcrc'
# rcup -v

echo "Ready to go!"
# echo "You may want to to setup auto-install of asdf plugins"

asdf_plugin_update() {
  if ! asdf plugin-list | grep -Fq "$1"; then
    asdf plugin-add "$1" "$2"
  fi

  asdf plugin-update "$1"
}

asdf_plugin_update "nodejs" "https://github.com/asdf-vm/asdf-nodejs"
export NODEJS_CHECK_SIGNATURES=no
asdf install nodejs latest

# asdf_plugin_update "tmux" "https://github.com/aphecetche/asdf-tmux.git"
# asdf install tmux latest

asdf_plugin_update "neovim"
asdf install neovim latest

asdf_plugin_update "sqlite"
asdf install sqlite latest

# asdf_plugin_update "cue"
# asdf install cue latest

asdf_plugin_update "golang"
asdf install golang latest

asdf_plugin_update "helm"
asdf install helm latest

asdf_plugin_update "lua"
asdf install lua latest

