#
# Guix environments
#
# Guix is a cross-platform package manager and a tool to instantiate and manage an operating
# system for Unix-like operating systems, based on the Nix package manager with Guile Scheme
# APIs and specializes in providing exclusively free software.
# Link: https://www.guix.info

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GUIX_SHOW="${SPACESHIP_GUIX_SHOW=true}"
SPACESHIP_GUIX_PREFIX="${SPACESHIP_GUIX_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_GUIX_SUFFIX="${SPACESHIP_GUIX_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_GUIX_SYMBOL="${SPACESHIP_GUIX_SYMBOL="🐐 "}"
SPACESHIP_GUIX_COLOR="${SPACESHIP_GUIX_COLOR="105"}"

# ------------------------------------------------------------------------------
# Section
# ----------------------------------------------- -------------------------------

spaceship_guix() {
  [[ $SPACESHIP_GUIX_SHOW == false ]] && return

  spaceship::exists guix || return

  # Show Guix when within a guix environment
  [[ ! -z $GUIX_ENVIRONMENT ]] || return

  local guix_environment="${$(basename $GUIX_ENVIRONMENT):0:8}"

  spaceship::section \
    "$SPACESHIP_GUIX_COLOR" \
    "$SPACESHIP_GUIX_PREFIX" \
    "$SPACESHIP_GUIX_SYMBOL$guix_environment" \
    "$SPACESHIP_GUIX_SUFFIX"
}
