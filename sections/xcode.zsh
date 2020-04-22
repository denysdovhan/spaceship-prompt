#
# Xcode
#
# Xcode is an integrated development environment for macOS.
# Link: https://developer.apple.com/xcode/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_XCODE_SHOW_LOCAL="${SPACESHIP_XCODE_SHOW_LOCAL=true}"
SPACESHIP_XCODE_SHOW_GLOBAL="${SPACESHIP_XCODE_SHOW_GLOBAL=false}"
SPACESHIP_XCODE_PREFIX="${SPACESHIP_XCODE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_XCODE_SUFFIX="${SPACESHIP_XCODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_XCODE_SYMBOL="${SPACESHIP_XCODE_SYMBOL="🛠 "}"
SPACESHIP_XCODE_COLOR="${SPACESHIP_XCODE_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Xcode
spaceship_xcode() {
  spaceship::exists xcenv || return

  local 'xcode_path'

  if [[ $SPACESHIP_XCODE_SHOW_GLOBAL == true ]] ; then
    xcode_path=$(xcenv version | sed 's/ .*//')
  elif [[ $SPACESHIP_XCODE_SHOW_LOCAL == true ]] ; then
    if [[ `xcenv local 2>/dev/null` ]] ; then
      xcode_path=$(xcenv version | sed 's/ .*//')
    fi
  fi

  if [ -n "${xcode_path}" ]; then
    local xcode_version_path=$xcode_path"/Contents/version.plist"
    if [ -f ${xcode_version_path} ]; then
      if spaceship::exists defaults; then
        local xcode_version=$(defaults read ${xcode_version_path} CFBundleShortVersionString)

        spaceship::section \
          "$SPACESHIP_XCODE_COLOR" \
          "$SPACESHIP_XCODE_PREFIX" \
          "${SPACESHIP_XCODE_SYMBOL}${xcode_version}" \
          "$SPACESHIP_XCODE_SUFFIX"
      fi
    fi
  fi
}
