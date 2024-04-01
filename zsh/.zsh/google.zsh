###########
# Google3 #
###########
function __blazebin_or_back() {
  if [[ "${PWD/*\/google3\/blaze-bin*}" ]]
     then cd "${PWD/\/google3//google3/blaze-bin}" > /dev/null
     else cd "${PWD/\/google3\/blaze-bin//google3}" > /dev/null
  fi
}

alias bb=" __blazebin_or_back"
alias tm="/google/data/ro/teams/tenantmanager/tools/tm"
alias project_id_translator="/google/bin/releases/oneplatform/chemist/project_id_number_translator"


###############
# g4d support #
###############
if [[ -f "/etc/bash_completion.d/g4d" ]]; then
  source /etc/bash_completion.d/g4d
fi

##############
# Fig prompt #
##############

# NOTE: This requires fig_prompt and fig_status.py which can be found at
# 

if [[ -f "$HOME/fig_status.py" ]]; then
  #Enable Fig prompt information
  source ~/.zsh/.goog_fig_p10k.zsh
else
  function setup_fig() {
    cp /google/src/head/depot/google3/experimental/fig_contrib/prompts/fig_status/fig_status.py ~/

    echo "Complete setup by adding sections in ~/.hgrc described in go/zsh-prompt#configure"
  }
fi

