export PATH=$HOME/bin/share/linux:$PATH

####################
# Google Cloud SDK #
####################
GCLOUD_SDK_DIR=$HOME/google-cloud-sdk/bin 
if [[ -d $GCLOUD_SDK_DIR ]]; then
  [[ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]] && source "$GCLOUD_SDK_DIR/path.zsh.inc"
fi

if [[ -f /etc/bash_completion.d/hgd ]]; then
  source /etc/bash_completion.d/hgd
fi

if [[ -f /etc/bash.bashrc.d/shell_history_forwarder.sh ]]; then
  source /etc/bash.bashrc.d/shell_history_forwarder.sh
fi

