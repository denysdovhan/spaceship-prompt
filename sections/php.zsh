#
# PHP
#
# PHP is a server-side scripting language designed primarily for web development.
# Link: http://www.php.net/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_PHP_SHOW="${SPACESHIP_PHP_SHOW=true}"
SPACESHIP_PHP_PREFIX="${SPACESHIP_PHP_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_PHP_SUFFIX="${SPACESHIP_PHP_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_PHP_SYMBOL="${SPACESHIP_PHP_SYMBOL="🐘 "}"
SPACESHIP_PHP_COLOR="${SPACESHIP_PHP_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of PHP
spaceship_php() {
  [[ $SPACESHIP_PHP_SHOW == false ]] && return

  # Show only if php files or composer.json exist in current directory
  [[ -n *.php(#qN^/) || -f composer.json ]] || return

  spaceship::exists php || return

  local php_version=$(php -r "echo phpversion();" 2>/dev/null)

  spaceship::section \
    "$SPACESHIP_PHP_COLOR" \
    "$SPACESHIP_PHP_PREFIX" \
    "${SPACESHIP_PHP_SYMBOL}v${php_version}" \
    "${SPACESHIP_PHP_SUFFIX}"
}
