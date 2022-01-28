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


###############
# g4d support #
###############
if [[ -f "/etc/bash_completion.d/g4d" ]]; then
  source /etc/bash_completion.d/g4d
fi

