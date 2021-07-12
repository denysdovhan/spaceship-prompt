#
# Git branch
#
# Show current git branch

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_BRANCH_SHOW="${SPACESHIP_GIT_BRANCH_SHOW=true}"
SPACESHIP_GIT_BRANCH_PREFIX="${SPACESHIP_GIT_BRANCH_PREFIX="$SPACESHIP_GIT_SYMBOL"}"
SPACESHIP_GIT_BRANCH_SUFFIX="${SPACESHIP_GIT_BRANCH_SUFFIX=""}"
SPACESHIP_GIT_BRANCH_COLOR="${SPACESHIP_GIT_BRANCH_COLOR="magenta"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_git_branch() {
  [[ $SPACESHIP_GIT_BRANCH_SHOW == false ]] && return

  local git_current_branch="$vcs_info_msg_0_"
  [[ -z "$git_current_branch" ]] && return

  git_current_branch="${git_current_branch#heads/}"
  git_current_branch="${git_current_branch/.../}"

  spaceship::section \
    "$SPACESHIP_GIT_BRANCH_COLOR" \
    "$SPACESHIP_GIT_BRANCH_PREFIX${git_current_branch}$SPACESHIP_GIT_BRANCH_SUFFIX"
}

# ------------------------------------------------------------------------------
# Hooks
# ------------------------------------------------------------------------------

# Print branch name
# USAGE:
#   spaceship_async_git_branch <workdir>
# EXAMPLE:
#   async_job spaceship spaceship_async_git_branch "$PWD"
spaceship_async_git_branch() {
  local workdir="$1"
  local ref="$(
    command git -C "$workdir" symbolic-ref --quiet HEAD 2>/dev/null ||
    command git -C "$workdir" rev-parse --short HEAD 2>/dev/null
  )"
  echo "${ref#refs/heads/}"
}

spaceship_async_git_branch_callback() {
  local branch_name="$1"

  # TODO: Store branch name

  # TODO: Rerender prompt
}
