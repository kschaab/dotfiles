# vim: filetype=zsh:

############################
# Show updates to dotfiles #
############################
git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles remote update &>/dev/null
DOTFILES_BRANCH="$( git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles rev-parse --abbrev-ref HEAD )"
DOTFILES_ALL_CHANGES="$( git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles diff master origin/master --name-status )"
DOTFILES_LOCAL_CHANGES="$( git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles status -u -s )"
if [[ -n "$DOTFILES_ALL_CHANGES" && -z "$DOTFILES_LOCAL_CHANGES" && "$DOTFILES_BRANCH" == "master" ]]; then
  echo "Synching dotfiles with latest changes"
  git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles pull --ff-only
elif [[ "$DOTFILES_LOCAL_CHANGES" == "$DOTFILES_ALL_CHANGES" ]]; then
  echo "Dotfiles have changed locally only:"
  echo "$DOTFILES_ALL_CHANGES"
elif [[ "$DOTFILES_BRANCH" != "master" ]]; then
  echo "Dotfiles not on master!"
else
  echo "Dotfiles have changed remotely and locally:"
  echo "$DOTFILES_ALL_CHANGES"
fi

ZSH_SCRIPT_DIR="$HOME/.zsh"
export PATH=$HOME/bin:$PATH

if [[ -d "$HOME/.npm-global/bin" ]]; then
  PATH=$PATH:$HOME/.npm-global/bin
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

######################
# OS dependent files #
######################
if [[ `uname` == 'Darwin' ]]; then
    source  "$ZSH_SCRIPT_DIR/mac.zsh"
fi

if [[ `uname` == 'Linux' ]]; then
    source "$ZSH_SCRIPT_DIR/linux.zsh"
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

# gcloud compleition
[[ -f "$GCLOUD_SDK_DIR/completion.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/completion.zsh.inc"

# fzf completion
[[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh"
[[ -f "/usr/share/doc/fzf/examples/completion.zsh" ]] && source "/usr/share/doc/fzf/examples/completion.zsh"

# Set vim to the default editor
export EDITOR=$(which vi)

###########
# Aliases #
###########
eval $(thefuck --alias)
alias ls=' ls -laG'
alias cd=' cd'

unset LESS;

########
# dirs #
########
DIRSTACKSIZE=9
setopt autopushd pushdminus pushdsilent pushdtohome pushd_ignore_dups
alias dh='dirs -v'
alias cd=' cd'

DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

alias ..=" cd .."
alias ..2=" cd ../.."
alias ..3=" cd ../../.."
alias ..4=" cd ../../../.."
alias ..5=" cd ../../../../.."

function _mkdir_cd() {
  mkdir -p -- $1 && cd -P -- $1
}
alias mcd=" _mkdir_cd"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f  "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

