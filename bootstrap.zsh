#!/usr/bin/env zsh

if ! (( $+commands[git] )) ; then
  echo "Bootstrap requires git, install and then continue."
  exit 1
fi

###########################
# bootstrap dotfiles repo #
###########################
if [[ ! -d $HOME/dotfiles/ ]]; then
  git clone https://github.com/kschaab/dotfiles.git $HOME/dotfiles
  pushd $HOME/dotfiles
  git remote set-url --push origin git@github.com:kschaab/dotfiles.git
  popd
fi

#############################################
# create directory to backup existing files #
#############################################
if [[ ! -d $HOME/.bak/ ]]; then
  mkdir $HOME/.bak
fi

##########################
# bootstrap each dotfile #
##########################
$HOME/dotfiles/zsh/setup/bootstrap.zsh
$HOME/dotfiles/vim/setup/bootstrap.zsh
$HOME/dotfiles/system/setup/bootstrap.zsh

