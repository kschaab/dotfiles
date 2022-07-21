#!/bin/zsh

# Powerlevel10k async prompt for Fig
# Depends on fig_prompt.py and async.zsh (zsh-async)

# Common global variables that specify what to cache where.
FIG_CACHE_BASE_DIR=/tmp/fig-cache
FIG_STATE_INDICATOR_FILES=(".hg/blackbox.log" ".citc/manifest.rawproto")
FIG_STATUS_FILE="status.txt"
FIG_STATE_HASH_FILE="state.hash"
# Lines from .blackbox.log matching the following pattern will be ignored for
# hash computation and thus will prevent the status being updated. Add commands
# in here that do not change the Fig state.
BLACKBOX_IGNORE=">.*(xl|ll|figstatus|status|diff|root|exportedcl|preloading|debugfetchconfig)"

# Choose an md5 tool that's available.
if command -v md5sum >> /dev/null; then
  MD5TOOL=md5sum
elif command -v md5 >> /dev/null; then
  MD5TOOL=md5
else
  MD5TOOL=cat
fi

# Returns the root directory of the current Fig client. Should only be called
# from within a Fig client.
function get_fig_client_root() {
  local root_dir="${PWD%/google3*}"
  echo "$root_dir"
}

# Returns the name of the current Fig client. Should only be called from within
# a Fig client.
function get_fig_client_name() {
  local root_dir="$( get_fig_client_root )"
  local client_name="${root_dir##/*/}"
  echo "$client_name"
}

# Returns the directory where we cache the status for the current Fig client.
function get_fig_client_cache_dir() {
  [ ! -d "$FIG_CACHE_BASE_DIR" ] && mkdir "$FIG_CACHE_BASE_DIR"
  client_name=$( get_fig_client_name )
  client_cache_dir="$FIG_CACHE_BASE_DIR/$client_name"
  # Make sure the cache dir exists.
  [ ! -d "$client_cache_dir" ] && mkdir "$client_cache_dir"
  echo "$client_cache_dir"
}

# Returns the hash of the file state of the current Fig client.
function get_fig_client_state_hash() {
  local state_hash=""
  local -a state_files
  for file in ${FIG_STATE_INDICATOR_FILES}; do
    file="$( get_fig_client_root )/${file}"
    if [ -f "$file" ]; then
      if [[ "$file" =~ ".*blackbox.log" ]]; then
        state_hash="${state_hash}\n$( egrep -v "${BLACKBOX_IGNORE}" "$file" | \
                                      ${MD5TOOL} )"
      else
        state_hash="${state_hash}\n$( ${MD5TOOL} "$file" )"
      fi
    fi
  done
  echo "$state_hash"
}

# Returns 0 if the status cache for the current Fig client is outdated and
# needs to be updated and 1 otherwise. Should only be called from within a Fig
# client.
function should_update_fig_status_cache() {
  local state_hash="$( get_fig_client_state_hash )"
  local cached_state_hash="emptycache"
  local cached_state_hash_file
  cached_state_hash_file="$( get_fig_client_cache_dir )/$FIG_STATE_HASH_FILE"
  if [ -f "$cached_state_hash_file" ]; then
    cached_state_hash=$(<"$cached_state_hash_file")
  fi
  if [ "$cached_state_hash" != "$state_hash" ]; then
    # Update cache since the state hash has changed.
    return 0
  fi

  # Do not update cache.
  return 1
}

# Updates the status cache for the current Fig client. Should only be called
# from within a Fig client.
function update_fig_status_cache() {
  local status_file="$( get_fig_client_cache_dir )/$FIG_STATUS_FILE"
  hg figstatus >! "$status_file"

  local state_hash="$( get_fig_client_state_hash )"
  local cached_state_hash_file
  cached_state_hash_file="$( get_fig_client_cache_dir )/$FIG_STATE_HASH_FILE"
  echo "$state_hash" >! "$cached_state_hash_file"
}

# Returns a multi-line output of the status of the current Fig client by either
# looking the status up in the cache file if the cache is current or loading it
# directly from Fig and updating the cache. Should only be called from within a
# Fig client.
function fig_status() {
  if should_update_fig_status_cache; then
    update_fig_status_cache
  fi
  local status_file="$( get_fig_client_cache_dir )/$FIG_STATUS_FILE"
  cat "$status_file"
}

# Returns whether the current directory is (likely) a Fig-on-CITC client.
function is_fig_client() {
  if [[ -d ${PWD%%/google3*}/.hg ]]; then
    return 0
  fi
  return 1
}

function _goog_fig_async() {
  local working_dir=$1
  cd $working_dir
  echo "$working_dir"

  if ! is_fig_client; then
    echo "None"
    return 0
  fi

  echo "$(fig_status)"
}

function _goog_fig_callback() {
  if ! is_fig_client; then
    return 0
  fi
  ret_value=("${(@f)3}")
  if [ "$ret_value[2]" != "None" ]; then
    local figstatus=("${ret_value[@]:1}")
    local dirty="$figstatus[1]$figstatus[2]$figstatus[3]"
    local untracked="$figstatus[4]"
    local cl=$figstatus[7]
    local branch=$figstatus[9]
    local cls_name=$figstatus[13]
    local rev=$figstatus[14]

    if [[ $branch == "p4head" ]]; then
      rev="p4head"
    fi

    local mergedir="$(get_fig_client_root)/.hg/merge/"
    local rebasefile="$(get_fig_client_root)/.hg/rebasestate"

    local conflicted=""

    # This directory only exists during a merge
    [[ -d $mergedir ]] && conflicted="merging"

    # This file only exists during a rebase
    [[ -e $rebasefile ]] && conflicted="rebasing"

    local color_clean='%76F'   # green foreground
    local color_dirty='%178F'  # yellow foreground
    local color_untracked='%104F'   # mediumpurple foreground
    local color_conflicted='%196F'  # red foreground

    local goog_icon=$'\uf7ac'
    local branch_icon=$'\ufb2b'
    local tag_icon=$'\uf9f8'
    local upload_icon=$'\ufa51'

    local color=$color_clean
    if [[ -n $untracked ]]; then
      color=$color_untracked
    elif [[ -n $dirty ]]; then
      color=$color_dirty
    fi


    local content="${color}$goog_icon"
    if [[ -n $conflicted ]]; then
      content+="$color_conflicted $conflicted$color"
    fi

    content+=" / ${branch_icon} ${rev}"
    if [[ -n $cls_name && $cls_name != "change-"* ]]; then
      content+=" / ${tag_icon}${cls_name}"
    fi
    if [[ -n $cl ]]; then
      content+=" / ${upload_icon}cl/${cl}"
    fi

    GOOG_FIG_PROMPT_OUTPUT[$ret_value[1]]=$content
    zle reset-prompt
    zle -R
  fi
}

async_init
async_start_worker goog_fig_worker -n
async_register_callback goog_fig_worker _goog_fig_callback
typeset -g -A GOOG_FIG_PROMPT_OUTPUT

prompt_goog_fig() {
  async_job goog_fig_worker _goog_fig_async $PWD
  local content='$GOOG_FIG_PROMPT_OUTPUT[$PWD]'
  p10k segment -e -t $content
  GOOG_FIG_PROMPT_OUTPUT=()
}

