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
SPACESHIP_GIT_SYMBOL="${SPACESHIP_GIT_SYMBOL=" "}"
if [ -z "$SPACESHIP_GIT_ORDER" ]; then
  SPACESHIP_GIT_ORDER=(
    branch
    status
  )
fi

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_git() {
  [[ $SPACESHIP_GIT_SHOW == false || -z $SPACESHIP_GIT_ORDER ]] && return

  spaceship::is_git || return

  local git_prompt

  for el in ${(Oa)SPACESHIP_GIT_ORDER}; do
    source "$SPACESHIP_ROOT/sections/git_${el}.zsh" # load dependency
    git_prompt="$(spaceship_git_${el})$git_prompt"
  done

  [[ -z $git_prompt ]] && return

  spaceship::section \
    'white' \
    "$SPACESHIP_GIT_PREFIX$git_prompt$SPACESHIP_GIT_SUFFIX"
}
