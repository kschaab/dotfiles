#!/usr/bin/env zsh
typeset -g ADOTDIR=$HOME/.antigen
typeset -g ADOT=$ADOTDIR

if [[ ! -d  $ADOTDIR ]]; then
    mkdir $ADOTDIR
fi

if [[ ! -f $ADOTDIR/antigen.zsh ]]; then
    curl -L git.io/antigen > $ADOTDIR/antigen.zsh
fi

typeset -g ANTIGEN_CACHE=false

source $ADOTDIR/antigen.zsh

antigen use oh-my-zsh
antigen bundle pip
antigen bundle command-not-found
antigen bundle autojump
antigen bundle npm
antigen bundle desyncr/auto-ls
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle hchbaw/auto-fu.zsh

antigen theme romkatv/powerlevel10k

antigen apply

