#
# pyenv
#
# pyenv lets you easily switch between multiple versions of Python.
# Link: https://github.com/pyenv/pyenv

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_PYENV_SHOW="${SPACESHIP_PYENV_SHOW=true}"
SPACESHIP_PYENV_PREFIX="${SPACESHIP_PYENV_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_PYENV_SUFFIX="${SPACESHIP_PYENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_PYENV_SYMBOL="${SPACESHIP_PYENV_SYMBOL="🐍 "}"
SPACESHIP_PYENV_COLOR="${SPACESHIP_PYENV_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of pyenv Python, including system.
spaceship_pyenv() {
  [[ $SPACESHIP_PYENV_SHOW == false ]] && return

  spaceship::exists pyenv || return # Do nothing if pyenv is not installed

  local pyenv_status=${$(pyenv version-name 2>/dev/null)//:/ }

  [[ $pyenv_status == system ]] && return

  spaceship::section \
    "$SPACESHIP_PYENV_COLOR" \
    "$SPACESHIP_PYENV_PREFIX" \
    "${SPACESHIP_PYENV_SYMBOL}${pyenv_status}" \
    "$SPACESHIP_PYENV_SUFFIX"
}
