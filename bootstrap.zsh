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

#################
# Run bootstrap #
#################
source "$HOME/dotfiles/setup/bootstrap.zsh"
