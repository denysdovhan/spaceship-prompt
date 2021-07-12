#
# Git tag
#
# Show last git tag

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

	
SPACESHIP_GIT_TAG_SHOW="${SPACESHIP_GIT_TAG_SHOW=true}"
SPACESHIP_GIT_TAG_PREFIX="${SPACESHIP_GIT_TAG_PREFIX=" @"}"
SPACESHIP_GIT_TAG_SUFFIX="${SPACESHIP_GIT_TAG_SUFFIX=""}"
SPACESHIP_GIT_TAG_COLOR="${SPACESHIP_GIT_TAG_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_git_tag() {
  [[ $SPACESHIP_GIT_TAG_SHOW == false ]] && return

  spaceship::is_git || return

  if [[ -n $(git tag) ]]; then
    git_tag=$(command git describe --tags --abbrev=0)

    spaceship::section \
    "$SPACESHIP_GIT_TAG_COLOR" \
    "$SPACESHIP_GIT_TAG_PREFIX$git_tag$SPACESHIP_GIT_TAG_SUFFIX"
  fi
}
