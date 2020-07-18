#!/usr/bin/env zsh

######################
# OS dependent files #
######################
if [[ `uname` == 'Darwin' ]]; then
    eval $(dirname "${(%):-%N}")/bootstrap.mac.zsh
fi

if [[ `uname` == 'Linux' ]]; then
    eval $(dirname "${(%):-%N}")/bootstrap.linux.zsh
fi
