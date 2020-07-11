#!/usr/bin/env zsh

[[ -f $HOME/.vimrc ]] && mv $HOME/.vimrc $HOME/.bak/.vimrc
echo "source $HOME/dotfiles/vim/vimrc" > $HOME/.vimrc

if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
  mkdir -p ~/.vim/bundle
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git
fi
