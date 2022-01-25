SCRIPT_DIR=${0:a:h}

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

if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi


if [[ -f /usr/share/doc/fzf/examples/completion.bash ]]; then
  source /usr/share/doc/fzf/examples/completion.bash
fi

####################
# Google functions #
####################
if [[ "$SCRIPT_DIR" == *"/google/"* ]]; then
  source $SCRIPT_DIR/google.zsh
fi
