#
# Mercurial (hg)
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_HG_SHOW="${SPACESHIP_HG_SHOW=true}"
SPACESHIP_HG_PREFIX="${SPACESHIP_HG_PREFIX="on "}"
SPACESHIP_HG_SUFFIX="${SPACESHIP_HG_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_HG_SYMBOL="${SPACESHIP_HG_SYMBOL="☿ "}"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/sections/hg_branch.zsh"
source "$SPACESHIP_ROOT/sections/hg_status.zsh"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show both hg branch and hg status:
#   spaceship_hg_branch
#   spaceship_hg_status
spaceship_hg() {
  [[ $SPACESHIP_HG_SHOW == false ]] && return

  local hg_branch hg_status

  __SS_DATA[section_result]=""
  spaceship_hg_branch
  hg_branch="${__SS_DATA[section_result]}"

  __SS_DATA[section_result]=""
  spaceship_hg_status
  hg_status="${__SS_DATA[section_result]}"

  [[ -z $hg_branch ]] && return

  spaceship::section \
    'white' \
    "$SPACESHIP_HG_PREFIX" \
    "${hg_branch}${hg_status}" \
    "$SPACESHIP_HG_SUFFIX"
}
