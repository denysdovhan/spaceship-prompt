#
# Mercurial (hg) branch
#
# Show current Mercurial branch

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

: "${SPACESHIP_HG_BRANCH_SHOW=true}"
: "${SPACESHIP_HG_BRANCH_PREFIX="$SPACESHIP_HG_SYMBOL"}"
: "${SPACESHIP_HG_BRANCH_SUFFIX=""}"
: "${SPACESHIP_HG_BRANCH_COLOR="magenta"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_hg_branch() {
  [[ $SPACESHIP_HG_BRANCH_SHOW == false ]] && return

  _is_hg || return

  _prompt_section \
    "$SPACESHIP_HG_BRANCH_COLOR" \
    "$SPACESHIP_HG_BRANCH_PREFIX"$(hg branch)"$SPACESHIP_HG_BRANCH_SUFFIX"
}
