export PATH=$HOME/bin/share/linux:$PATH

####################
# Google Cloud SDK #
####################
GCLOUD_SDK_DIR=$HOME/google-cloud-sdk/bin 
if [[ -d $GCLOUD_SDK_DIR ]; then
  [[ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/path.zsh.inc"
fi

