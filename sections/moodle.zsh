#
# Moodle - Moodle is an Open-Source learning platform written in PHP
# 
# Link: https://moodle.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_MOODLE_SHOW="${SPACESHIP_MOODLE_SHOW=true}"
SPACESHIP_MOODLE_PREFIX="${SPACESHIP_MOODLE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_MOODLE_SUFFIX="${SPACESHIP_MOODLE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_MOODLE_SYMBOL="${SPACESHIP_MOODLE_SYMBOL="🎓"}"
SPACESHIP_MOODLE_COLOR="${SPACESHIP_MOODLE_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of PHP
spaceship_moodle() {
  [[ $SPACESHIP_MOODLE_SHOW == false ]] && return

  # Show only if version.php exist in current directory
  [[ -f version.php ]] || return

  # only if the version.php file contains MOODLE_INTERNAL
  grep -q "MOODLE_INTERNAL" version.php; [ $? -eq 0 ]  || return

  # only if the version.php file contains $release
  grep -q "\$release" version.php; [ $? -eq 0 ]  || return

  local moodle_version=$(cat version.php| grep -G "^\$release.*[0-9.+].*'" | awk '{print $3}' | awk '{print substr($1,2);}')

  spaceship::section \
    "$SPACESHIP_MOODLE_COLOR" \
    "$SPACESHIP_MOODLE_PREFIX" \
    "${SPACESHIP_MOODLE_SYMBOL} v${moodle_version}" \
    "${SPACESHIP_MOODLE_SUFFIX}"
}
