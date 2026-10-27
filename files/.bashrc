#! /bin/bash

# env for every bash - including `ssh host cmd` and agent shells
. $HOME/.env.base

# below here: interactive only (sshd makes bash read this for one-off commands too)
[[ $- == *i* ]] || return

set -o vi

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

# each init is a few ms (measured 2026-10-27: ~16ms total mac, ~5ms bb8)
command -v fzf      >/dev/null && eval "$(fzf --bash)"
command -v zoxide   >/dev/null && eval "$(zoxide init bash)"
command -v starship >/dev/null && eval "$(starship init bash)"
# command -v direnv >/dev/null && eval "$(direnv hook bash)"
# eval "$(/Users/phil/.local/bin/mise activate bash)"
