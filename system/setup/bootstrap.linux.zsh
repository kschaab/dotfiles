#!/usr/bin/env zsh

###########################
# Install linux utilities #
###########################
if (( $EUID != 0 )); then
    echo "In order to bootstrap Linux utilities you must run ${0:a} as root."
    exit
fi

apt update
apt install autojump bat ranger fzf
