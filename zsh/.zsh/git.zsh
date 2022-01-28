#!/usr/bin/env zsh

####################
# git prune merged #
####################
function _git_prune_merged()
{
  git fetch --all
  git remote | xargs git remote prune
  git branch -vv | grep -E '(origin|upstream)/.*: gone]' | awk '{print $1}' | xargs git branch -D
}

alias git-prune-merged='_git_prune_merged'

#####################
# git switch branch #
#####################
function _git_switch_branch
{
  git switch "$(git branch --sort=-committerdate | fzf --no-sort | tr -d '[:space:'] | tr -d '*')"
}

alias gs='_git_switch_branch'

################
# g completion #
################

# Source directories to search through
local SOURCE_DIRS=(
  ~/source
)

# Preferred source directories, if there are collisions these will be used over any others. The order of this array
# dictates the order of the preferred directories.
local PREFERENCES=(
  ~/source/dev
)

# Constant entry
typeset -gxA SOURCE_DIRS_MAP
SOURCE_DIRS_MAP[dev]=~/source/dev
SOURCE_DIRS_MAP[clean]=~/source/clean
SOURCE_DIRS_MAP[scratch]=~/source/scratch
SOURCE_DIRS_MAP[source]=~/source
SOURCE_DIRS_MAP[temp]=~/source/temp

# Finds git repositories in the specified dir
function _g_process_dir()
{
  if [[ ! -d $1 ]]; then
    return
  fi
  setopt localoptions NULL_GLOB

  for dir in $1/**/.git/; do
    local SOURCE_DIRECTORY=$(dirname $dir)
    local CURRENT_DIRECTORY=$SOURCE_DIRECTORY
    local ALIAS=$(basename $SOURCE_DIRECTORY)
    while [[ ! -z "$SOURCE_DIRS_MAP[$ALIAS]" ]]; do
      if [[ "$SOURCE_DIRS_MAP[$ALIAS]" == "$SOURCE_DIRECTORY" ]]; then
        break
      fi
      CURRENT_DIRECTORY=$(dirname $CURRENT_DIRECTORY)
      ALIAS=$(basename $CURRENT_DIRECTORY)/$ALIAS
    done
    if [[ "$SOURCE_DIRS_MAP[$ALIAS]" == "$SOURCE_DIRECTORY" ]]; then
      continue
    fi
    if [[ -z "$SOURCE_DIRS_MAP[$ALIAS]" ]]; then
      SOURCE_DIRS_MAP[$ALIAS]=$SOURCE_DIRECTORY
    fi
  done
}

# Navigates to an alias
function _g_dir()
{
  local DUMP_USAGE=
  if [[ "$1" == "" ]]; then
    >&2 echo "Must specify an alias, can be one of the following:"
    _g_dump_map "    "
    return 1
  fi

  if [[ "$1" == "list" ]]; then
    _g_dump_map ""
    return 0
  fi

  if [[ "$1" == "." ]]; then
    cd $(git rev-parse --show-toplevel)
    return 0
  fi

  local change_to=$SOURCE_DIRS_MAP[$1]
  if [[ -z $change_to ]]; then
    >&2 echo "$1 is not a valid alias.  Valid values are as follows:"
    _g_dump_map "    "
    return 1
  fi

  cd $change_to
}

alias g=_g_dir
alias g.="_g_dir ."

# Dumps the aliases and the directories to which they refer
function _g_dump_map()
{
  local LENGTH=$(( 0 ))
  for key value in ${(kv)SOURCE_DIRS_MAP}; do
    if [[ ${#key} -gt $LENGTH ]]; then
      LENGTH=${#key}
    fi
  done
  for key value in ${(kv)SOURCE_DIRS_MAP}; do
    local pad=$(( $LENGTH - ${#key} + 2 ))
    local padding=""
    for i in {1..$pad}; do
      padding="$padding "
    done
    echo "$1$key $padding-> $value"
  done
}

# Completion function
function _g_completion()
{
  local candidates=('list:List shortcuts')
  for key value in ${(kv)SOURCE_DIRS_MAP}; do
    candidates+=("$key: $value")
  done
  _describe 'g' candidates
}

#for p in $PREFERENCES; do
#  _g_process_dir $p
#done

#for s in $SOURCE_DIRS; do
#  _g_process_dir $s
#done

#compdef _g_completion _g_dir
