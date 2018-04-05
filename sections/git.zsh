#
# Git
#
# Builds a Git prompt section from the array SPACESHIP_GIT_ORDER. Each element
# ELEMENT in the array corresponds to a function spaceship_git_ELEMENT
# defined in a file sections/git_ELEMENT.

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_SHOW="${SPACESHIP_GIT_SHOW=true}"
SPACESHIP_GIT_PREFIX="${SPACESHIP_GIT_PREFIX="on "}"
SPACESHIP_GIT_SUFFIX="${SPACESHIP_GIT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
if [ -z "$SPACESHIP_GIT_ORDER" ]; then
  SPACESHIP_GIT_ORDER=(
    branch
    status
  )
fi

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

for subsection in "$SPACESHIP_ROOT"/sections/git_*.zsh; do
  source $subsection
done

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_git() {
  [[ $SPACESHIP_GIT_SHOW == false || -z $SPACESHIP_GIT_ORDER ]] && return

  spaceship::is_git || return

  # prefix${^array} prefixes each element in $array with prefix
  local git_prompt=$(spaceship::compose_prompt git_${^SPACESHIP_GIT_ORDER})

  [[ -z $git_prompt ]] && return

  spaceship::section \
    'white' \
    "$SPACESHIP_GIT_PREFIX$git_prompt$SPACESHIP_GIT_SUFFIX"
}
