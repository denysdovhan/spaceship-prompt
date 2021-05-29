#
# Sudo
#
# Sudo is a tool that allows a system administrator to delegate authority to
# users or groups.
# Link: https://www.sudo.ws

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

# This should not be enabled by default as anyone with passwordless sudo
# configured would find it horribly annoying.
SPACESHIP_SUDO_SHOW="${SPACESHIP_SUDO_SHOW=auto}"
SPACESHIP_SUDO_PREFIX="${SPACESHIP_SUDO_PREFIX="with "}"
SPACESHIP_SUDO_SUFFIX="${SPACESHIP_SUDO_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_SUDO_SYMBOL="${SPACESHIP_SUDO_SYMBOL="⚡ "}"
SPACESHIP_SUDO_COLOR="${SPACESHIP_SUDO_COLOR="yellow"}"
SPACESHIP_SUDO_STATUS="${SPACESHIP_SUDO_STATUS="sudo"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show an indicator if the current shell has passwordless sudo available.
spaceship_sudo() {
  # If SPACESHIP_SUDO_SHOW is false, don't show sudo section
  [[ $SPACESHIP_SUDO_SHOW == false ]] && return

  # Check if sudo command is available for execution
  spaceship::exists sudo || return

  [[ $SPACESHIP_SUDO_SHOW == auto && $(sudo -Sln 2>/dev/null | awk '
    BEGIN { r = 0 }
    /^User/{ p = 1 }
    p && $2 == "NOPASSWD:"{ r = 1; exit }
    END { print r == 1 ? "true" : "false" }
  ') == true ]] && return

  if ! sudo -Sln >/dev/null 2>&1; then
    return
  fi

  # Display sudo section
  spaceship::section \
    "$SPACESHIP_SUDO_COLOR" \
    "$SPACESHIP_SUDO_PREFIX" \
    "$SPACESHIP_SUDO_SYMBOL$SPACESHIP_SUDO_STATUS" \
    "$SPACESHIP_SUDO_SUFFIX"
}
