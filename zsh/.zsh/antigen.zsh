#!/usr/bin/env zsh
typeset -g ADOTDIR=$HOME/.antigen
typeset -g ADOT=$ADOTDIR

if [[ -d  $ADOTDIR ]] && [[ ! -d $ADOTDIR/.git ]]; then
    rm -rf $ADOTDIR
fi

if [[ ! -f $ADOTDIR/antigen.zsh ]]; then
    git clone https://github.com/zsh-users/antigen.git $ADOTDIR
    curl -L git.io/antigen > $ADOTDIR/antigen.zsh
fi

typeset -g ANTIGEN_CACHE=false

source $ADOTDIR/antigen.zsh

antigen use oh-my-zsh
antigen bundle pip
antigen bundle command-not-found
antigen bundle autojump
antigen bundle npm
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle Vifon/deer
antigen bundle mafredri/zsh-async --branch=main
antigen bundle aubreypwd/zsh-plugin-fd@1.0.0
antigen bundle Aloxaf/fzf-tab

antigen theme romkatv/powerlevel10k

antigen apply
autoload -U deer
zle -N deer
bindkey '^t' deer

