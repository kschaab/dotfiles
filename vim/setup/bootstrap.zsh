#!/usr/bin/env zsh

[[ -f $HOME/.vimrc ]] && mv $HOME/.vimrc $HOME/.bak/.vimrc
echo "source $HOME/dotfiles/vim/vimrc" > $HOME/.vimrc

if [[ ! -d $HOME/.vim/bundle/Vundle.vim ]]; then
  mkdir -p $HOME/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

vim -c 'PluginInstall' -c 'qa!'
