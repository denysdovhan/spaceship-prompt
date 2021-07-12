#
# Flutter
#
# Flutter is Google’s UI toolkit for building beautiful, 
# natively compiled applications for mobile, web, and desktop from a single codebase.
# Link: https://flutter.dev/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_FLUTTER_SHOW="${SPACESHIP_FLUTTER_SHOW=true}"
SPACESHIP_FLUTTER_PREFIX="${SPACESHIP_FLUTTER_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_FLUTTER_SUFFIX="${SPACESHIP_FLUTTER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_FLUTTER_SYMBOL="${SPACESHIP_FLUTTER_SYMBOL="« "}"
SPACESHIP_FLUTTER_DEFAULT_VERSION="${SPACESHIP_FLUTTER_DEFAULT_VERSION=""}"
SPACESHIP_FLUTTER_COLOR="${SPACESHIP_FLUTTER_COLOR="cyan"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of flutter, exception system.
spaceship_flutter() {
  [[ $SPACESHIP_FLUTTER_SHOW == false ]] && return

  # Show FLUTTER status only for Flutter-projects folders
  [[ -f pubspec.yaml && .packages && .dart_tool ]] || return

  local 'flutter_version'

  if spaceship::exists flutter; then
    flutter_version=$(flutter --version | sed -n 1p | tr " " "\n" | sed -n 2p 2>/dev/null)
  else
    return
  fi

  [[ $flutter_version == $SPACESHIP_FLUTTER_DEFAULT_VERSION ]] && return

  spaceship::section \
    "$SPACESHIP_FLUTTER_COLOR" \
    "$SPACESHIP_FLUTTER_PREFIX" \
    "${SPACESHIP_FLUTTER_SYMBOL}v${flutter_version}" \
    "$SPACESHIP_FLUTTER_SUFFIX"
}
