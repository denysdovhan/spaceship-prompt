#
# Jabba 
#
# A simple Java Version Manager, providing a pain-free experience of installing and switching between 
# different version of JDK 
# Link: https://github.com/shyiko/jabba

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_JABBA_SHOW="${SPACESHIP_JABBA_SHOW=true}"
SPACESHIP_JABBA_PREFIX="${SPACESHIP_JABBA_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_JABBA_SUFFIX="${SPACESHIP_JABBA_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_JABBA_SYMBOL="${SPACESHIP_JABBA_SYMBOL="☕️ "}"
SPACESHIP_JABBA_COLOR="${SPACESHIP_JABBA_COLOR="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Ruby
spaceship_jabba() {
  [[ $SPACESHIP_JABBA_SHOW == false ]] && return

  # Show versions only for Java-specific folders
  [[ -f pom.xml || -n *.gradle(#qN^/)||  -n *.java(#qN^/) ]] || return

  local 'jabba_version'

  if spaceship::exists jabba; then
    jabba_version=$(jabba current)
  else
    return
  fi

  [[ -z $jabba_version || "${jabba_version}" == "system" ]] && return

  # Add 'v' before jabba version that starts with a number
  [[ "${jabba_version}" =~ ^[0-9].+$ ]] && jabba_version="v${jabba_version}"

  spaceship::section \
    "$SPACESHIP_JABBA_COLOR" \
    "$SPACESHIP_JABBA_PREFIX" \
    "${SPACESHIP_JABBA_SYMBOL}${jabba_version}" \
    "$SPACESHIP_JABBA_SUFFIX"
}
