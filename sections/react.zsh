#
# React
#
# An open-source JavaScript web framework, created by Facebook
# Link: https://reactjs.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_REACT_SHOW="${SPACESHIP_REACT_SHOW=true}"
SPACESHIP_REACT_PREFIX="${SPACESHIP_REACT_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_REACT_SUFFIX="${SPACESHIP_REACT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_REACT_SYMBOL="${SPACESHIP_REACT_SYMBOL="⚛ ️"}"
SPACESHIP_REACT_COLOR="${SPACESHIP_REACT_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of React
spaceship_react() {
  [[ $SPACESHIP_REACT_SHOW == false ]] && return

  if [[ -f ./node_modules/react/package.json ]] && spaceship::exists npm; then
    if spaceship::exists jq; then
      react_version=$(jq -r '.version' ./node_modules/react/package.json 2>/dev/null)
    elif spaceship::exists python; then
      react_version=$(python -c "import json; print(json.load(open('node_modules/react/package.json'))['version'])" 2>/dev/null)
    elif spaceship::exists node; then
      react_version=$(node -p "require('./node_modules/react/package.json').version" 2> /dev/null)
    fi
  fi

  [[ -z $react_version || "$react_version" == "null" || "$react_version" == "undefined" ]] && return

  spaceship::section \
    "$SPACESHIP_REACT_COLOR" \
    "$SPACESHIP_REACT_PREFIX" \
    "${SPACESHIP_REACT_SYMBOL}v${react_version}" \
    "$SPACESHIP_REACT_SUFFIX"
}
