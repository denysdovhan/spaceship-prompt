#
# Git
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_SHOW="${SPACESHIP_GIT_SHOW=true}"
SPACESHIP_GIT_PREFIX="${SPACESHIP_GIT_PREFIX="on "}"
SPACESHIP_GIT_SUFFIX="${SPACESHIP_GIT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_GIT_SYMBOL="${SPACESHIP_GIT_SYMBOL=" "}"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/sections/git_branch.zsh"
source "$SPACESHIP_ROOT/sections/git_commit_msg.zsh"
source "$SPACESHIP_ROOT/sections/git_diffstat.zsh"
source "$SPACESHIP_ROOT/sections/git_status.zsh"
source "$SPACESHIP_ROOT/sections/git_tag.zsh"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show both git branch and git status:
#   spaceship_git_branch
#   spaceship_git_status
spaceship_git() {
  [[ $SPACESHIP_GIT_SHOW == false ]] && return

  local git_branch="$(spaceship_git_branch)" 
  local git_tag="$(spaceship_git_tag)"
  local git_status="$(spaceship_git_status)"
  local git_diffstat="$(spaceship_git_diffstat)"
  local git_commit_msg="$(spaceship_git_commit_msg)" 

  [[ -z $git_branch ]] && return

  spaceship::section \
    'white' \
    "$SPACESHIP_GIT_PREFIX" \
    "${git_branch}${git_status}${git_tag}${git_diffstat}${git_commit_msg}" \
    "$SPACESHIP_GIT_SUFFIX"
}
