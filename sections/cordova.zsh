#
# Cordova
#
# Apache Cordova is an open-source mobile development framework.
# It allows you to use standard web technologies - HTML5, CSS3, and JavaScript
# for cross-platform development
# Link: https://cordova.apache.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_CORDOVA_SHOW="${SPACESHIP_CORDOVA_SHOW=true}"
SPACESHIP_CORDOVA_PREFIX="${SPACESHIP_CORDOVA_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_CORDOVA_SUFFIX="${SPACESHIP_CORDOVA_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_CORDOVA_SYMBOL="${SPACESHIP_CORDOVA_SYMBOL="🤖 "}"
SPACESHIP_CORDOVA_DEFAULT_VERSION="${SPACESHIP_CORDOVA_DEFAULT_VERSION=""}"
SPACESHIP_CORDOVA_COLOR="${SPACESHIP_CORDOVA_COLOR="039"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of cordova, exception system.
spaceship_cordova() {
  [[ $SPACESHIP_CORDOVA_SHOW == false ]] && return

  # Show CORDOVA status only for Cordova-specific folders
  [[ -f config.xml || -d platforms ]] || return

  local 'cordova_version'

  if spaceship::exists cvm; then
    cordova_version=$(cvm version | awk '{print $1}')
  elif spaceship::exists cordova; then
    cordova_version=$(cordova -v | awk '{print $1}')
  else
    return
  fi

  [[ $cordova_version == $SPACESHIP_CORDOVA_DEFAULT_VERSION ]] && return

  spaceship::section \
    "$SPACESHIP_CORDOVA_COLOR" \
    "$SPACESHIP_CORDOVA_PREFIX" \
    "${SPACESHIP_CORDOVA_SYMBOL}${cordova_version}" \
    "$SPACESHIP_CORDOVA_SUFFIX"
}
