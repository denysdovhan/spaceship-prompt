#
# Prompt character
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_CHAR_PREFIX="${SPACESHIP_CHAR_PREFIX=""}"
SPACESHIP_CHAR_SUFFIX="${SPACESHIP_CHAR_SUFFIX=""}"
SPACESHIP_CHAR_SYMBOL="${SPACESHIP_CHAR_SYMBOL="➜ "}"
SPACESHIP_CHAR_SYMBOL_ROOT="${SPACESHIP_CHAR_SYMBOL_ROOT="$SPACESHIP_CHAR_SYMBOL"}"
SPACESHIP_CHAR_SYMBOL_SECONDARY="${SPACESHIP_CHAR_SYMBOL_SECONDARY="$SPACESHIP_CHAR_SYMBOL"}"
SPACESHIP_CHAR_COLOR_SUCCESS="${SPACESHIP_CHAR_COLOR_SUCCESS="green"}"
SPACESHIP_CHAR_COLOR_FAILURE="${SPACESHIP_CHAR_COLOR_FAILURE="red"}"
SPACESHIP_CHAR_COLOR_SECONDARY="${SPACESHIP_CHAR_COLOR_SECONDARY="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Paint $PROMPT_SYMBOL in red if previous command was fail and
# paint in green if everything was OK.
spaceship_char() {
  local 'color' 'char'

  if [[ ! -z $SPACESHIP_CHAR_COLORS ]] ; then
      local length="${#SPACESHIP_CHAR_COLORS[@]}"
      local rand=`od -An -N4 -tuI < /dev/urandom`
      local index=$(( $rand % ($length + 1) ))
      color=$SPACESHIP_CHAR_COLORS[index]
  elif [[ $RETVAL -eq 0 ]]; then
    color="$SPACESHIP_CHAR_COLOR_SUCCESS"
  else
    color="$SPACESHIP_CHAR_COLOR_FAILURE"
  fi

  if [[ $UID -eq 0 ]]; then
    char="$SPACESHIP_CHAR_SYMBOL_ROOT"
  else
    char="$SPACESHIP_CHAR_SYMBOL"
  fi

  spaceship::section \
    "$color" \
    "$SPACESHIP_CHAR_PREFIX" \
    "$char" \
    "$SPACESHIP_CHAR_SUFFIX"
}

