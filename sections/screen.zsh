#
# Screen
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_SCREEN_SHOW="${SPACESHIP_SCREEN_SHOW=true}"
SPACESHIP_SCREEN_PREFIX="${SPACESHIP_SCREEN_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_SCREEN_SUFFIX="${SPACESHIP_SCREEN_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_SCREEN_SYMBOL="${SPACESHIP_SCREEN_SYMBOL="💻 "}"
SPACESHIP_SCREEN_COLOR="${SPACESHIP_NODE_COLOR="870087"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_screen() {
  [[ $SPACESHIP_SCREEN_SHOW == false ]] && return

  # show screen only when we are in a screen session
  # when we are in a screen session then:
  # "$TERM" = "screen"
  local 'screen_status'
  if [[ "$TERM" == *"screen"* ]]; then
  	screen_status="screen"
  fi
  [[ -z $screen_status ]] && return

  # to print the word screen use below:
#   "$SPACESHIP_SCREEN_SYMBOL$screen_status" \

  spaceship::section \
    "$SPACESHIP_SCREEN_COLOR" \
    "$SPACESHIP_SCREEN_PREFIX" \
    "$SPACESHIP_SCREEN_SYMBOL${STY#*.}" \
    "$SPACESHIP_SCREEN_SUFFIX"
}
