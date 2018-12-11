#
# Fossil
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_FOSSIL_SHOW="${SPACESHIP_FOSSIL_SHOW=true}"
SPACESHIP_FOSSIL_PREFIX="${SPACESHIP_FOSSIL_PREFIX="on "}"
SPACESHIP_FOSSIL_SUFFIX="${SPACESHIP_FOSSIL_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_FOSSIL_SYMBOL="${SPACESHIP_FOSSIL_SYMBOL="🝤 "}"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/sections/fossil_branch.zsh"
source "$SPACESHIP_ROOT/sections/fossil_status.zsh"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show both fossil branch and fossil status:
#   spaceship_fossil_branch
#   spaceship_fossil_status
spaceship_fossil() {
  [[ $SPACESHIP_FOSSIL_SHOW == false ]] && return

  local fossil_branch="$(spaceship_fossil_branch)" fossil_status="$(spaceship_fossil_status)"

  [[ -z $fossil_branch ]] && return

  spaceship::section \
    'white' \
    "$SPACESHIP_FOSSIL_PREFIX" \
    "${fossil_branch}${fossil_status}" \
    "$SPACESHIP_FOSSIL_SUFFIX"
}
