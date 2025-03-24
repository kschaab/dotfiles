export PATH=$HOME/homebrew/bin:$HOME/bin/share/darwin:$PATH
export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH

####################
# Google Cloud SDK #
####################
GCLOUD_SDK_DIR=$HOME/google-cloud-sdk/bin
if [[ -d $GCLOUD_SDK_DIR ]]; then
  [[ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/path.zsh.inc"
fi

CC_GCLOUD=$HOME/Library/Application\ Support/cloud-code/installer/google-cloud-sdk/bin
if [[ -d "$CC_GCLOUD" ]]; then
  export CC_GCLOUD
fi

###############################################
# Connect to cloudtop (keithsc.c.googlers.com #
###############################################
function ct() {
  rw -r --tmux_iterm -t --tmux_session work keithsc.c.googlers.com
}
