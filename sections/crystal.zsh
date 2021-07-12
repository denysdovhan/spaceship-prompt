#
# Crystal
#
# Crystal is a programming that aimes to be "fast as C, slick as Ruby."
# Link: https://www.crystal-lang.org

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_CRYSTAL_SHOW="${SPACESHIP_CRYSTAL_SHOW=true}"
SPACESHIP_CRYSTAL_PREFIX="${SPACESHIP_CRYSTAL_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_CRYSTAL_SUFFIX="${SPACESHIP_CRYSTAL_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_CRYSTAL_SYMBOL="${SPACESHIP_CRYSTAL_SYMBOL="💎 "}"
SPACESHIP_CRYSTAL_COLOR="${SPACESHIP_CRYSTAL_COLOR=069}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Crystal
spaceship_crystal() {
  [[ $SPACESHIP_CRYSTAL_SHOW == false ]] && return

  # If there are Crystal-specific files in current directory
  [[ -f shard.yml || -n *.cr(#qN^/) ]] || return

  spaceship::exists crystal || return

  local crystal_version=$(crystal --version | sed -En 's/Crystal ([[:digit:]]+\.[[:digit:]]+\.[[:digit:]]).*/\1/p')

  spaceship::section \
    "$SPACESHIP_CRYSTAL_COLOR" \
    "$SPACESHIP_CRYSTAL_PREFIX" \
    "${SPACESHIP_CRYSTAL_SYMBOL}v${crystal_version}" \
    "$SPACESHIP_CRYSTAL_SUFFIX"
}
