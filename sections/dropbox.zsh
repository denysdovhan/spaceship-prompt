#
# Dropbox
#
# A free service that lets you bring your photos, docs, and videos anywhere and share them easily.
# Link: https://www.dropbox.com/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_DROPBOX_SHOW="${SPACESHIP_DROPBOX_SHOW=true}"
SPACESHIP_DROPBOX_PREFIX="${SPACESHIP_DROPBOX_PREFIX="with "}"
SPACESHIP_DROPBOX_SUFFIX="${SPACESHIP_DROPBOX_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_DROPBOX_SYMBOL="${SPACESHIP_DROPBOX_SYMBOL="  "}"
SPACESHIP_DROPBOX_COLOR="${SPACESHIP_DROPBOX_COLOR="blue"}"
SPACESHIP_DROPBOX_ENABLED="${(A)=SPACESHIP_DROPBOX_ENABLED="up to date" "syncing"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show dropbox status
spaceship_dropbox() {
  # If SPACESHIP_DROPBOX_SHOW is false, don't show dropbox section
  [[ $SPACESHIP_DROPBOX_SHOW == false ]] && return

  # Check if dropbox-cli command is available for execution
  spaceship::exists dropbox-cli || return

  # Get dropbox status for current directory
  # Cut removes the current directory from the output
  local 'dropbox_status'="$(dropbox-cli filestatus . 2>/dev/null | cut -d\  -f2-)"

  # skip segment if dropbox status not in enabled list
  [[ "${SPACESHIP_DROPBOX_ENABLED[(i)$dropbox_status:t]}" -le "${#SPACESHIP_DROPBOX_ENABLED}" ]] || return

  # Display dropbox section
  spaceship::section \
    "$SPACESHIP_DROPBOX_COLOR" \
    "$SPACESHIP_DROPBOX_PREFIX" \
    "$SPACESHIP_DROPBOX_SYMBOL$dropbox_status" \
    "$SPACESHIP_DROPBOX_SUFFIX"
}
