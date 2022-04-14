#!/usr/bin/env sh


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
# (cd $DOTFILES && . ./other/mac_settings.sh)
source ./other/mac_settings.sh

echo "brewing..."
# assume we are in the correct directory...
# (cd $DOTFILES && brew bundle)
brew bundle

# echo "fzf install..."
# $(brew --prefix)/opt/fzf/install

echo "linking dotfiles"
export RCRC='$DOTFILES/rcrc'
rcup -v

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
asdf install nodejs 16.6.1

asdf_plugin_update "ruby" "https://github.com/asdf-vm/asdf-ruby"
asdf install ruby 3.0.1

asdf_plugin_update "tmux" "https://github.com/aphecetche/asdf-tmux.git"
asdf install tmux 3.2

asdf_plugin_update "neovim"
asdf install neovim 0.5.0

asdf_plugin_update "erlang" "https://github.com/asdf-vm/asdf-erlang.git"
asdf install erlang 24.0.4

asdf_plugin_update "elixir" "https://github.com/asdf-vm/asdf-elixir.git"
asdf install elixir 1.12.2-otp-24 

