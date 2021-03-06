# vim: filetype=zsh:

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

ZSH_SCRIPT_DIR="${0:a:h}/.zsh"

export PATH=$HOME/bin:$PATH

######################
# OS dependent files #
######################
if [[ `uname` == 'Darwin' ]]; then
    source  "$ZSH_SCRIPT_DIR/mac.zsh"
fi

if [[ `uname` == 'Linux' ]]; then
    source "$ZSH_SCRIPT_DIR/linux.zsh"
fi

#######################
# Optional Components #
#######################
GCLOUD_SDK_DIR=$(dirname $(dirname $(which gcloud)))

[[ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/path.zsh.inc"

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
source "$ZSH_SCRIPT_DIR/antigen.zsh"

##############
# Completion #
##############
fpath=($ZSH_SCRIPT_DIR/site-functions "${fpath[@]}")
autoload -Uz compinit && compinit
autoload -U $fpath[1]/*(.:t)

source "$ZSH_SCRIPT_DIR/git.zsh"

[[ -f "$GCLOUD_SDK_DIR/completion.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/completion.zsh.inc"

# Set vim to the default editor
export EDITOR=$(which vi)

###########
# Aliases #
###########
eval $(thefuck --alias)
alias ls=' ls -laG'
alias cd=' cd'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f  "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

