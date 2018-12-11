#
# Fossil branch
#
# Show current Fossil branch

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_FOSSIL_BRANCH_SHOW="${SPACESHIP_FOSSIL_BRANCH_SHOW=true}"
SPACESHIP_FOSSIL_BRANCH_PREFIX="${SPACESHIP_FOSSIL_BRANCH_PREFIX="$SPACESHIP_FOSSIL_SYMBOL"}"
SPACESHIP_FOSSIL_BRANCH_SUFFIX="${SPACESHIP_FOSSIL_BRANCH_SUFFIX=""}"
SPACESHIP_FOSSIL_BRANCH_COLOR="${SPACESHIP_FOSSIL_BRANCH_COLOR="magenta"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_fossil_branch() {
  [[ $SPACESHIP_FOSSIL_BRANCH_SHOW == false ]] && return

  spaceship::is_fossil || return

  local fossil_info=$(fossil branch | cut -f2 -d" ")

  spaceship::section \
    "$SPACESHIP_FOSSIL_BRANCH_COLOR" \
    "$SPACESHIP_FOSSIL_BRANCH_PREFIX"$fossil_info"$SPACESHIP_FOSSIL_BRANCH_SUFFIX"
}
