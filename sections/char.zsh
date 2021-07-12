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
SPACESHIP_CHAR_VI_MODE="${SPACESHIP_CHAR_VI_MODE=false}"
SPACESHIP_CHAR_VI_MODE_SYMBOL="${SPACESHIP_CHAR_VI_MODE_SYMBOL="➩ "}"
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

  if [[ $RETVAL -eq 0 ]]; then
    color="$SPACESHIP_CHAR_COLOR_SUCCESS"
  else
    color="$SPACESHIP_CHAR_COLOR_FAILURE"
  fi

  if [[ $UID -eq 0 ]]; then
    char="$SPACESHIP_CHAR_SYMBOL_ROOT"
  else
    char="$SPACESHIP_CHAR_SYMBOL"
  fi

  if [[ $SPACESHIP_CHAR_VI_MODE == true ]] && [[ ${KEYMAP} == "vicmd" ]]; then
    char="$SPACESHIP_CHAR_VI_MODE_SYMBOL"
  fi

  spaceship::section \
    "$color" \
    "$SPACESHIP_CHAR_PREFIX" \
    "$char" \
    "$SPACESHIP_CHAR_SUFFIX"
}
