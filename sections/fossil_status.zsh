#
# Fossil status
#
# Show Fossil status

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_FOSSIL_STATUS_SHOW="${SPACESHIP_FOSSIL_STATUS_SHOW=true}"
SPACESHIP_FOSSIL_STATUS_PREFIX="${SPACESHIP_FOSSIL_STATUS_PREFIX=" ["}"
SPACESHIP_FOSSIL_STATUS_SUFFIX="${SPACESHIP_FOSSIL_STATUS_SUFFIX="]"}"
SPACESHIP_FOSSIL_STATUS_COLOR="${SPACESHIP_FOSSIL_STATUS_COLOR="red"}"
SPACESHIP_FOSSIL_STATUS_UNTRACKED="${SPACESHIP_FOSSIL_STATUS_UNTRACKED="?"}"
SPACESHIP_FOSSIL_STATUS_ADDED="${SPACESHIP_FOSSIL_STATUS_ADDED="+"}"
SPACESHIP_FOSSIL_STATUS_MODIFIED="${SPACESHIP_FOSSIL_STATUD_MODIFIED="!"}"
SPACESHIP_FOSSIL_STATUS_DELETED="${SPACESHIP_FOSSIL_STATUS_DELETED="✘"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Check if current dir is a fossil repo and show fossil status as indicators
spaceship_fossil_status() {
  [[ $SPACESHIP_FOSSIL_STATUS_SHOW == false ]] && return

  spaceship::is_fossil || return

  local INDEX=$(fossil changes --differ 2>/dev/null) fossil_status=""

  # Indicators are suffixed instead of prefixed to each other to
  # provide uniform view across git, mercurial and fossil indicators
  if $(echo "$INDEX" | grep -E '^\EXTRA '  &> /dev/null); then
    fossil_status="$SPACESHIP_FOSSIL_STATUS_UNTRACKED$fossil_status"
  fi
  if $(echo "$INDEX" | grep -E '^\ADDED ' &> /dev/null); then
    fossil_status="$SPACESHIP_FOSSIL_STATUS_ADDED$fossil_status"
  fi
  if $(echo "$INDEX" | grep -E '^\EDITED ' &> /dev/null); then
    fossil_status="$SPACESHIP_FOSSIL_STATUS_MODIFIED$fossil_status"
  fi
  if $(echo "$INDEX" | grep -E '^\DELETED ' &> /dev/null); then
    fossil_status="$SPACESHIP_FOSSIL_STATUS_DELETED$fossil_status"
  fi

  if [[ -n $fossil_status ]]; then
    spaceship::section \
      "$SPACESHIP_FOSSIL_STATUS_COLOR" \
      "$SPACESHIP_FOSSIL_STATUS_PREFIX"$fossil_status"$SPACESHIP_FOSSIL_STATUS_SUFFIX"
  fi
}
