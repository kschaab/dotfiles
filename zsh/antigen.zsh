#!/usr/bin/env zsh

if [[ ! -d  $HOME/.antigen ]]; then
    mkdir $HOME/.antigen
fi

if [[ ! -f $HOME/.antigen/antigen.zsh ]]; then
    curl -L git.io/antigen > $HOME/.antigen/antigen.zsh
fi

source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle pip
antigen bundle command-not-found

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply
