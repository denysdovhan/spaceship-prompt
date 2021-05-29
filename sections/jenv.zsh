#
# jEnv
#
# jEnv is a command line tool to help you forget how to set the JAVA_HOME environment variable
# Link: https://www.jenv.be/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_JENV_SHOW="${SPACESHIP_JENV_SHOW=true}"
SPACESHIP_JENV_COLOR="${SPACESHIP_JENV_COLOR="black"}"
SPACESHIP_JENV_PREFIX="${SPACESHIP_JENV_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_JENV_SUFFIX="${SPACESHIP_JENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_JENV_SYMBOL="${SPACESHIP_JENV_SYMBOL="☕ "}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current java version set by jenv
spaceship_jenv() {
  [[ $SPACESHIP_JENV_SHOW == false ]] && return

  spaceship::exists jenv || return

  local java_version=$(jenv version | cut -d'(' -f1 | xargs)

  spaceship::section \
    "$SPACESHIP_JENV_COLOR" \
    "$SPACESHIP_JENV_PREFIX" \
    "${SPACESHIP_JENV_SYMBOL}${java_version}" \
    "$SPACESHIP_JENV_SUFFIX"
}
