export PATH=$HOME/homebrew/bin:$HOME/bin/share/darwin:$PATH
export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH

####################
# Google Cloud SDK #
####################
GCLOUD_SDK_DIR="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/"

if [[ -d $GCLOUD_SDK_DIR ]]; then
  [[ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/path.zsh.inc"
fi

CC_GCLOUD=$HOME/Library/Application\ Support/cloud-code/installer/google-cloud-sdk/bin
if [[ -d "$CC_GCLOUD" ]]; then
  export CC_GCLOUD
fi

#################
# Morning gcert #
#################
function gc() {
  if [[ -z "$1" ]]; then
    echo "Must specify host to use when running gc" 1>&2
    return 1
  fi

  for i in {1..3}; do gcert && break || echo "Retrying..."; done && ssh $1 -t 'echo "Running gcert on $HOST" && for i in {1..3}; do gcert && break || echo "Retrying..."; done'
}
