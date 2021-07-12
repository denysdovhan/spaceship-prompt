#
# Architecture
#
# This section displays the CPU architecture of the environment inside which the
# shell is running. The output will be
# - arm64 for shell running natively on M1 chips
# - i386 for shell running natively on Intel machines or via Rosetta2 emulation

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_ARCH_SHOW="${SPACESHIP_ARCH_SHOW=true}"
SPACESHIP_ARCH_PREFIX="${SPACESHIP_ARCH_PREFIX="on "}"
SPACESHIP_ARCH_SUFFIX="${SPACESHIP_ARCH_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_ARCH_SYMBOL="${SPACESHIP_ARCH_SYMBOL="💻 "}"
SPACESHIP_ARCH_COLOR="${SPACESHIP_ARCH_COLOR="white"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_arch() {
  # If SPACESHIP_ARCH_SHOW is false, don't show the architecture section
  [[ $SPACESHIP_ARCH_SHOW == false ]] && return

  # Check if `arch` command is available for execution
  spaceship::exists arch || return

  local 'architecture'

  architecture=$(arch)

  # Display architecture section
  spaceship::section \
    "$SPACESHIP_ARCH_COLOR" \
    "$SPACESHIP_ARCH_PREFIX" \
    "${SPACESHIP_ARCH_SYMBOL}${architecture}" \
    "$SPACESHIP_ARCH_SUFFIX"
}