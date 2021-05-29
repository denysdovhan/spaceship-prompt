#
# V
#
# V is a simple, fast, safe, compiled language for developing maintainable software.
# Link: https://vlang.io/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_V_SHOW="${SPACESHIP_V_SHOW=true}"
SPACESHIP_V_PREFIX="${SPACESHIP_V_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_V_SUFFIX="${SPACESHIP_V_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_V_SYMBOL="${SPACESHIP_V_SYMBOL="𝗩 "}"
SPACESHIP_V_COLOR="${SPACESHIP_V_COLOR="cyan"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of V, exception system.
spaceship_v() {
  [[ $SPACESHIP_V_SHOW == false ]] && return

  # Show V status only for folders containing V files
  [[ -n *.v(#qN^/) ]] || return

  local 'v_version'

  if spaceship::exists v; then
    v_version=$(v version)
  else
    return
  fi

  spaceship::section \
    "$SPACESHIP_V_COLOR" \
    "$SPACESHIP_V_PREFIX" \
    "${SPACESHIP_V_SYMBOL}${v_version}" \
    "$SPACESHIP_V_SUFFIX"
}
