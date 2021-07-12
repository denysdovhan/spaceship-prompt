#
# Direnv
#
# Shows the current status of direnv and which .envrc is currently loaded. 
# You can get it at https://github.com/direnv/direnv

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_DIRENV_SHOW="${SPACESHIP_DIRENV_SHOW=true}"
SPACESHIP_DIRENV_PREFIX="${SPACESHIP_DIRENV_PREFIX="with "}"
SPACESHIP_DIRENV_SUFFIX="${SPACESHIP_DIRENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_DIRENV_SYMBOL="${SPACESHIP_DIRENV_SYMBOL="🌳 "}"
SPACESHIP_DIRENV_COLOR="${SPACESHIP_DIRENV_COLOR="green"}"
SPACESHIP_DIRENV_STATUS_NOTALLOWED="${SPACESHIP_DIRENV_STATUS_NOTALLOWED="[✘]"}"
SPACESHIP_DIRENV_STATUS_NOTHOOKED="${SPACESHIP_DIRENV_STATUS_NOTHOOKED="[!]"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_direnv() {
  [[ $SPACESHIP_DIRENV_SHOW == false ]] && return

  # Check if direnv command is available for execution
  spaceship::exists direnv  || return

  local 'direnv_status'
  local 'direnv_info'

  # read in direnv status
  direnv_info=$( direnv status )

  # Show section only if a .envrc is found in dir or parent dir
  echo $direnv_info | grep "Found RC" &>/dev/null || return

  # Display foldername of .envrc in section
  direnv_status=$( echo $direnv_info | grep "Found RC path" | awk '{print $4}' | xargs dirname | xargs basename )

  # Display status of direnv
  if $( echo $direnv_info | command grep "Found RC allowed false" &>/dev/null ); then
    direnv_status="$direnv_status $SPACESHIP_DIRENV_STATUS_NOTALLOWED"
  elif $( echo $direnv_info | command grep "Loaded RC" &>/dev/null ); then
    direnv_status="$direnv_status"
  else
    direnv_status="$direnv_status $SPACESHIP_DIRENV_STATUS_NOTHOOKED"
  fi

  # Display foobar section
  spaceship::section \
    "$SPACESHIP_DIRENV_COLOR" \
    "$SPACESHIP_DIRENV_PREFIX" \
    "$SPACESHIP_DIRENV_SYMBOL$direnv_status" \
    "$SPACESHIP_DIRENV_SUFFIX"
}
