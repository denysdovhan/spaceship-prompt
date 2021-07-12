#
# vi-mode
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_VI_MODE_SHOW="${SPACESHIP_VI_MODE_SHOW=true}"
SPACESHIP_VI_MODE_PREFIX="${SPACESHIP_VI_MODE_PREFIX=""}"
SPACESHIP_VI_MODE_SUFFIX="${SPACESHIP_VI_MODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_VI_MODE_INSERT="${SPACESHIP_VI_MODE_INSERT="[I]"}"
SPACESHIP_VI_MODE_NORMAL="${SPACESHIP_VI_MODE_NORMAL="[N]"}"
SPACESHIP_VI_MODE_COLOR="${SPACESHIP_VI_MODE_COLOR="white"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current vi-mode mode
spaceship_vi_mode() {
  [[ $SPACESHIP_VI_MODE_SHOW == true ]] || return

  local mode_indicator="${SPACESHIP_VI_MODE_INSERT}"

  case "${KEYMAP}" in
    main|viins)
      mode_indicator="${SPACESHIP_VI_MODE_INSERT}"
      ;;
    vicmd)
      mode_indicator="${SPACESHIP_VI_MODE_NORMAL}"
      ;;
  esac

  spaceship::section \
    "$SPACESHIP_VI_MODE_COLOR" \
    "$SPACESHIP_VI_MODE_PREFIX" \
    "$mode_indicator" \
    "$SPACESHIP_VI_MODE_SUFFIX"
}

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------

# Temporarily switch to vi-mode
spaceship_vi_mode_enable() {
  function zle-keymap-select() { zle reset-prompt ; zle -R }
  zle -N zle-keymap-select
  bindkey -v
}

# Temporarily switch to emacs-mode
spaceship_vi_mode_disable() {
  bindkey -e
}
