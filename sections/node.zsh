#
# Node.js
#
# Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine.
# Link: https://nodejs.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_NODE_SHOW="${SPACESHIP_NODE_SHOW=true}"
SPACESHIP_NODE_PREFIX="${SPACESHIP_NODE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_NODE_SUFFIX="${SPACESHIP_NODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_NODE_SYMBOL="${SPACESHIP_NODE_SYMBOL="⬢ "}"
SPACESHIP_NODE_DEFAULT_VERSION="${SPACESHIP_NODE_DEFAULT_VERSION=""}"
SPACESHIP_NODE_COLOR="${SPACESHIP_NODE_COLOR="green"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of node, exception system.
spaceship_node() {
  [[ $SPACESHIP_NODE_SHOW == false ]] && return

  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

  local 'node_version'

  if spaceship::exists nvm; then
    node_version=$(nvm current 2>/dev/null)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif spaceship::exists nodenv; then
    node_version=$(nodenv version-name)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif spaceship::exists node; then
    node_version=$(node -v 2>/dev/null | sed -e 's/\r//g')
  else
    return
  fi

  [[ $node_version == $SPACESHIP_NODE_DEFAULT_VERSION ]] && return

  spaceship::section \
    "$SPACESHIP_NODE_COLOR" \
    "$SPACESHIP_NODE_PREFIX" \
    "${SPACESHIP_NODE_SYMBOL}${node_version}" \
    "$SPACESHIP_NODE_SUFFIX"
}
