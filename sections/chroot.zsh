#
# Chroot environment name
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_CHROOT_SHOW="${SPACESHIP_CHROOT_SHOW:=true}"
SPACESHIP_CHROOT_PREFIX="${SPACESHIP_CHROOT_PREFIX:="using "}"
SPACESHIP_CHROOT_SUFFIX="${SPACESHIP_CHROOT_SUFFIX:="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_CHROOT_COLOR="${SPACESHIP_CHROOT_COLOR:="magenta"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# If logged in to a chroot environment, display the name in the prompt
spaceship_chroot() {
  [[ $SPACESHIP_CHROOT_SHOW == false ]] && return

  local debian_chroot

  if [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  [[ -z "$debian_chroot" ]] && return

  _prompt_section \
    "$SPACESHIP_CHROOT_COLOR" \
    "$SPACESHIP_CHROOT_PREFIX" \
    "$debian_chroot" \
    "$SPACESHIP_CHROOT_SUFFIX"
}
