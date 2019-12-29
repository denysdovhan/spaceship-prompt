#
#  Kubernetes (kubectl)
#
# Kubernetes is an open-source system for deployment, scaling,
# and management of containerized applications.
# Link: https://kubernetes.io/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_KUBECONTEXT_SHOW="${SPACESHIP_KUBECONTEXT_SHOW=true}"
SPACESHIP_KUBECONTEXT_PREFIX="${SPACESHIP_KUBECONTEXT_PREFIX="at "}"
SPACESHIP_KUBECONTEXT_SUFFIX="${SPACESHIP_KUBECONTEXT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
# Additional space is added because ☸️ is much bigger than the other symbols
# See: https://github.com/denysdovhan/spaceship-prompt/pull/432
SPACESHIP_KUBECONTEXT_SYMBOL="${SPACESHIP_KUBECONTEXT_SYMBOL="☸️  "}"
SPACESHIP_KUBECONTEXT_COLOR="${SPACESHIP_KUBECONTEXT_COLOR="cyan"}"
SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW="${SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW=true}"
SPACESHIP_KUBECONTEXT_COLOR_GROUPS=(${SPACESHIP_KUBECONTEXT_COLOR_GROUPS=})
SPACESHIP_KUBECONTEXT_CACHE_DIR="${SPACESHIP_KUBECONTEXT_CACHE_DIR:-"${XDG_CACHE_HOME:-$HOME/.cache}/spaceship-prompt"}"
SPACESHIP_KUBECONTEXT_CACHE_FILE="${SPACESHIP_KUBECONTEXT_CACHE_DIR}/kubecontext-cache"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------
kubecontext_file_newer_than() {
    local left_mtime
    local right_mtime
    local left=$1
    local right=$2

    if stat -c "%s" /dev/null &>/dev/null; then
        # GNU stat
        left_mtime=$(stat -L -c %Y ${left})
        right_mtime=$(stat -L -c %Y ${right})
    else
        left_mtime=$(stat -L -f %m ${left})
        right_mtime=$(stat -L -f %m ${right})
    fi

    [[ ${left_mtime} -gt ${right_mtime} ]]

}
kubecontext_cache() {
    [[ -d ${SPACESHIP_KUBECONTEXT_CACHE_DIR} ]] || mkdir -p ${SPACESHIP_KUBECONTEXT_CACHE_DIR}
    [[ -r ${SPACESHIP_KUBECONTEXT_CACHE_FILE} ]] || TZ=UTC touch -t '197001010000' ${SPACESHIP_KUBECONTEXT_CACHE_FILE}
    for conf in  $(echo ${KUBECONFIG:-$HOME/.kube/config} | tr ':' ' '); do
        [[ -r ${conf} ]] || continue
        if kubecontext_file_newer_than ${conf} ${SPACESHIP_KUBECONTEXT_CACHE_FILE}; then
            echo "$(query_kubecontext)" > ${SPACESHIP_KUBECONTEXT_CACHE_FILE}
            break
        fi
    done
    cat $SPACESHIP_KUBECONTEXT_CACHE_FILE
}

query_kubecontext() {
  kubectl config view --minify \
    --output=jsonpath='{range .contexts[*]}{.name} {.context.namespace}{end}' 2>/dev/null
}
get_kubecontext_only() {
  kubecontext_cache | awk '{print $1}'
}
get_kubecontext_with_namespace() {
    kubecontext_cache | awk '/.*default$/{print $1;exit} !$2{print $1;exit} {printf $1 " (" $2 ")"}'
}

# Show current context in kubectl
spaceship_kubecontext() {
  [[ $SPACESHIP_KUBECONTEXT_SHOW == false ]] && return

  spaceship::exists kubectl || return


  if [[ $SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW == true ]]; then
    kube_context=$(get_kubecontext_with_namespace)
  else
    kube_context=$(get_kubecontext_only)
  fi
  [[ -z "$kube_context" ]] && return

  # Apply custom color to section if $kube_context matches a pattern defined in SPACESHIP_KUBECONTEXT_COLOR_GROUPS array.
  # See Options.md for usage example.
  local len=${#SPACESHIP_KUBECONTEXT_COLOR_GROUPS[@]}
  local it_to=$((len / 2))
  local 'section_color' 'i'
  for ((i = 1; i <= $it_to; i++)); do
    local idx=$(((i - 1) * 2))
    local color="${SPACESHIP_KUBECONTEXT_COLOR_GROUPS[$idx + 1]}"
    local pattern="${SPACESHIP_KUBECONTEXT_COLOR_GROUPS[$idx + 2]}"
    if [[ "$kube_context" =~ "$pattern" ]]; then
      section_color=$color
      break
    fi
  done

  [[ -z "$section_color" ]] && section_color=$SPACESHIP_KUBECONTEXT_COLOR

  spaceship::section \
    "$section_color" \
    "$SPACESHIP_KUBECONTEXT_PREFIX" \
    "${SPACESHIP_KUBECONTEXT_SYMBOL}${kube_context}" \
    "$SPACESHIP_KUBECONTEXT_SUFFIX"
}
