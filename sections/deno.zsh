#
# Deno
#
# Deno is secure runtime for JavaScript and TypeScript.
# Link: https://deno.land/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_DENO_SHOW="${SPACESHIP_DENO_SHOW=true}"
SPACESHIP_DENO_PREFIX="${SPACESHIP_DENO_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_DENO_SUFFIX="${SPACESHIP_DENO_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_DENO_SYMBOL="${SPACESHIP_DENO_SYMBOL="🦕 "}"
SPACESHIP_DENO_DEFAULT_VERSION="${SPACESHIP_DENO_DEFAULT_VERSION=""}"
SPACESHIP_DENO_COLOR="${SPACESHIP_DENO_COLOR="cyan"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Deno
spaceship_deno() {
  [[ $SPACESHIP_DENO_SHOW == false ]] && return

  # Show Deno status only for Deno-specific folders
  [[ -n {mod,dep,main,cli}.ts(#qN^/) ]] || return

  local 'deno_version'

  if spaceship::exists dvm; then
    deno_version=$(dvm current 2>/dev/null)
  elif spaceship::exists deno; then
    deno_version=$(deno --version 2>/dev/null | head -1 | cut -d' ' -f2)
  else
    return
  fi

  [[ $deno_version == $SPACESHIP_DENO_DEFAULT_VERSION ]] && return

  spaceship::section \
    "$SPACESHIP_DENO_COLOR" \
    "$SPACESHIP_DENO_PREFIX" \
    "${SPACESHIP_DENO_SYMBOL}${deno_version}" \
    "$SPACESHIP_DENO_SUFFIX"
}
