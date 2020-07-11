#!/usr/bin/env zsh

##############################
# Install homebrew if needed #
##############################
if ! command -v $HOME/homebrew/bin/brew > /dev/null 2>&1 ;  then
    git clone https://github.com/mxcl/homebrew.git $HOME/homebrew
fi

export PATH=$HOME/homebrew/bin:$PATH
export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH

##############
# Nerd fonts #
##############
if (( $+commands[brew] )); then
    (brew tap | grep -Eq ^homebrew/cask-fonts$) || brew tap homebrew/cask-fonts
    brew cask list font-hack-nerd-font > /dev/null 2>&1 || brew cask install font-hack-nerd-font
fi