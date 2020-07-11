#!/usr/bin/env zsh

[[ -f $HOME/.zshrc ]] && mv $HOME/.zshrc $HOME/.bak/.zshrc
echo "source $HOME/dotfiles/zsh/zshrc" > $HOME/.zshrc

case `uname` in
    Darwin)
        ################
        # setup on mac #
        ################
        $(dirname "${(%):-%N}")/mac.zsh
    ;;
    Linux)
    ;;
esac
