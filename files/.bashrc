#! /bin/bash
set -o vi

. $HOME/.env.base
export GG_ENV="local"


# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
. $HOME/.fzf.bash
# source <(COMPLETE=bash jj)
[ -f ~/.config/system/comp_jj.bash ] && source ~/.config/system/comp_jj.bash

if [ -f $HOME/.config/system/sensible.bash ]; then
   source $HOME/.config/system/sensible.bash
fi

. $HOME/.config/system/aliases
. $HOME/.config/system/functions
. $HOME/.config/system/tools


bind "set completion-ignore-case on"
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

eval "$(zoxide init bash)"
eval "$(starship init bash)"
eval "$(direnv hook bash)"
# eval "$(/Users/phil/.local/bin/mise activate bash)"
