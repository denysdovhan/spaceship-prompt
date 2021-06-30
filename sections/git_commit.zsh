#
# Git commit
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_COMMIT_SHOW="${SPACESHIP_GIT_COMMIT_SHOW=true}"
SPACESHIP_GIT_COMMIT_PREFIX="${SPACESHIP_GIT_COMMIT_PREFIX=" #"}"
SPACESHIP_GIT_COMMIT_SUFFIX="${SPACESHIP_GIT_COMMIT_SUFFIX=""}"
SPACESHIP_GIT_COMMIT_COLOR="${SPACESHIP_GIT_COMMIT_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_git_commit() {
  [[ $SPACESHIP_GIT_COMMIT_SHOW == false ]] && return

  spaceship::is_git || return

  git_commit=$(command git rev-parse --short HEAD 2> /dev/null)

  # Get commit short commit hash
  if [[ -n $git_commit ]]; then
    # Commit prefixes are colorized
    spaceship::section \
      "$SPACESHIP_GIT_COMMIT_COLOR" \
      "$SPACESHIP_GIT_COMMIT_PREFIX$git_commit$SPACESHIP_GIT_COMMIT_SUFFIX"
  fi
}
