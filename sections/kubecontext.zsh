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

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current context in kubectl
spaceship_kubecontext() {
  [[ $SPACESHIP_KUBECONTEXT_SHOW == false ]] && return

  spaceship::exists kubectl || return

  local kube_context=$(kubectl config current-context 2>/dev/null)
  [[ -z $kube_context ]] && return

  local section_color

  # Apply custom color to section if context name is defined in of SPACESHIP_KUBECONTEXT_COLORGROUPS KV map.
  # See Options.md for usage example.
  if [[ ${#SPACESHIP_KUBECONTEXT_COLORGROUPS[@]} -gt 0 ]]; then
    local pattern color
    for pattern color in ${(kv)SPACESHIP_KUBECONTEXT_COLORGROUPS}; do
      if [[ "$kube_context" =~ "$pattern" ]]; then
        section_color=$color
        break
      fi
    done
  fi
  [[ -z "$section_color" ]] && section_color=$SPACESHIP_KUBECONTEXT_COLOR

  if [[ $SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW == true ]]; then
    local kube_namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    [[ -n $kube_namespace && "$kube_namespace" != "default" ]] && kube_context="$kube_context ($kube_namespace)"
  fi

  spaceship::section \
    "$section_color" \
    "$SPACESHIP_KUBECONTEXT_PREFIX" \
    "${SPACESHIP_KUBECONTEXT_SYMBOL}${kube_context}" \
    "$SPACESHIP_KUBECONTEXT_SUFFIX"
}
