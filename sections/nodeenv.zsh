#
# Nodeenv
#
# nodeenv is a tool to create isolated Node environments.
# Link: http://ekalinin.github.io/nodeenv/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_NODE_ENV_SHOW="${SPACESHIP_NODE_ENV_SHOW=true}"
SPACESHIP_NODE_ENV_PREFIX="${SPACESHIP_NODE_ENV_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_NODE_ENV_SUFFIX="${SPACESHIP_NODE_ENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_NODE_ENV_SYMBOL="${SPACESHIP_NODE_ENV_SYMBOL=""}"
# The (A) expansion flag creates an array, the '=' activates word splitting
SPACESHIP_NODE_ENV_GENERIC_NAMES="${(A)=SPACESHIP_NODE_ENV_GENERIC_NAMES=venv .venv env .env}"
SPACESHIP_NODE_ENV_COLOR="${SPACESHIP_NODE_ENV_COLOR="green"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current virtual environment (Node).
spaceship_nodeenv() {
  [[ $SPACESHIP_NODE_ENV_SHOW == false ]] && return

  # Check if the current directory running via Nodeenv
  [ -n "$NODE_VIRTUAL_ENV" ] || return

  local 'nodeenv'

  if [[ "${SPACESHIP_NODE_ENV_GENERIC_NAMES[(i)$NODE_VIRTUAL_ENV:t]}" -le \
        "${#SPACESHIP_NODE_ENV_GENERIC_NAMES}" ]]
  then
    nodeenv="$NODE_VIRTUAL_ENV:h:t"
  else
    nodeenv="$NODE_VIRTUAL_ENV:t"
  fi

spaceship::section \
    "$SPACESHIP_NODE_ENV_COLOR" \
    "$SPACESHIP_NODE_ENV_PREFIX" \
    "${SPACESHIP_NODE_ENV_SYMBOL}${nodeenv}" \
    "$SPACESHIP_NODE_ENV_SUFFIX"
}
