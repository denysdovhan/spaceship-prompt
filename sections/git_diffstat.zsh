
#
# Prints line counts of diff (added and removed)
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_DIFFSTAT_SHOW="${SPACESHIP_GIT_DIFFSTAT_SHOW=true}"
SPACESHIP_GIT_DIFFSTAT_PREFIX="${SPACESHIP_GIT_DIFFSTAT_PREFIX=" "}"
SPACESHIP_GIT_DIFFSTAT_SUFFIX="${SPACESHIP_GIT_DIFFSTAT_SUFFIX=""}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_git_diffstat() {
  [[ $SPACESHIP_GIT_DIFFSTAT_SHOW == false ]] && return

  spaceship::is_git || return

  # Shows count of lines added in green (with '+' prefix) and lines removed in red (with '-' prefix)
  # e.g. "+21 -7"
  
  git_diffstat=$(command git diff --staged --numstat HEAD | awk 'NF==3 {added+=$1; removed+=$2} END {printf("\x1B[32m+%d\x1B[0m \x1B[31m-%d\x1B[0m\n", added, removed)}')

  # Only show the diffstat if there are files staged.
  if ! git diff-index --quiet HEAD; then
    # Diffstats are colorized, so no color is necessary.
    spaceship::section \
      '' \
      "$SPACESHIP_GIT_DIFFSTAT_PREFIX$git_diffstat$SPACESHIP_GIT_DIFFSTAT_SUFFIX"
  fi
}