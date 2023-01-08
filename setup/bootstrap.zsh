
######################
# OS dependent files #
######################
if [[ `uname` == 'Darwin' ]]; then
    source "${0:a:h}/bootstrap.mac.zsh"
fi

if [[ `uname` == 'Linux' ]]; then
    source "${0:a:h}/bootstrap.linux.zsh"
fi

if [[ ! -d "$HOME/bin" ]]; then
    mkdir "$HOME/bin"
fi

echo 'Reflecting zsh and vim files'

###############################
# Use stow to create symlinks #
###############################
stow -d $HOME/dotfiles zsh
stow -d $HOME/dotfiles vim
stow -d $HOME/dotfiles/bin -t $HOME/bin share

#######################
# Install vim plugins #
#######################
if [[ ! -d $HOME/.vim/bundle/Vundle.vim ]]; then
  mkdir -p $HOME/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

vim --clean '+source ~/.vimrc' +PluginInstall +qall
