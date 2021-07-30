export PATH=$HOME/homebrew/bin:$HOME/bin/share/darwin:$PATH
export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH

####################
# Google Cloud SDK #
####################
GCLOUD_SDK_DIR="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/"

if [[ -d $GCLOUD_SDK_DIR ]]; then
  [[ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/path.zsh.inc"
fi

