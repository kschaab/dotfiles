###############
# Update repo #
###############
if [[ -z "${DOTFILES_REPOSITORY_UPDATED}" ]]; then 
  # Update the repository then re-source the file to pick up the changes
  git --git-dir=$HOME/dotfiles/.git fetch --all > /dev/null && git --git-dir=$HOME/dotfiles/.git merge --ff-only > /dev/null || echo "$HOME/dotfiles is dirty and cannot be fast-forwarded."
  DOTFILES_REPOSITORY_UPDATED=true
  source  "${(%):-%N}"
  return 0
fi

zsh_dir=$(dirname "${(%):-%N}")/.zsh

######################
# OS dependent files #
######################
if [[ `uname` == 'Darwin' ]]; then
    source  "$zsh_dir/mac.zsh"
fi

if [[ `uname` == 'Linux' ]]; then
    source "$zsh_dir/linux.zsh"
fi

#################################
# Powerlevel 10k instant prompt #
#################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###########
# history #
###########
HISTFILE=$HOME/.cache/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history share_history hist_ignore_space

setopt auto_pushd

###########
# Antigen #
###########
source "$zsh_dir/antigen.zsh"

##############
# Completion #
##############
fpath=($zsh_dir/site-functions "${fpath[@]}")
autoload -Uz compinit && compinit
autoload -U $zsh_dir/*(.:t)

source "$zsh_dir/git.zsh"

# Set vim to the default editor
export EDITOR=$(which vi)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f  "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"