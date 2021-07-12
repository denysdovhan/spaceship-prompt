#
# Package
#
# Current package version.
# These package managers supported:
#   * npm
#   * lerna
#   * Cargo
#   * Pub (Flutter)

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_PACKAGE_SHOW="${SPACESHIP_PACKAGE_SHOW=true}"
SPACESHIP_PACKAGE_PREFIX="${SPACESHIP_PACKAGE_PREFIX="is "}"
SPACESHIP_PACKAGE_SUFFIX="${SPACESHIP_PACKAGE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_PACKAGE_SYMBOL="${SPACESHIP_PACKAGE_SYMBOL="📦 "}"
SPACESHIP_PACKAGE_COLOR="${SPACESHIP_PACKAGE_COLOR="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_package() {
  [[ $SPACESHIP_PACKAGE_SHOW == false ]] && return

  # Show package version only when repository is a package
  local package_version

  if [[ -f package.json ]] && spaceship::exists npm; then
    if spaceship::exists jq; then
      package_version=$(jq -r '.version' package.json 2>/dev/null)
    elif spaceship::exists python; then
      package_version=$(python -c "import json; print(json.load(open('package.json'))['version'])" 2>/dev/null)
    elif spaceship::exists node; then
      package_version=$(node -p "require('./package.json').version" 2> /dev/null)
    fi
  fi

  # Show package version from lerna.json if is a lerna monorepo
  # Note: lerna does not have to be installed in the global context
  # so checking for lerna binary does not make sense
  if [[ -f lerna.json ]] && spaceship::exists npm; then
    if spaceship::exists jq; then
      package_version=$(jq -r '.version' lerna.json 2>/dev/null)
    elif spaceship::exists python; then
      package_version=$(python -c "import json; print(json.load(open('lerna.json'))['version'])" 2>/dev/null)
    elif spaceship::exists node; then
      package_version=$(node -p "require('./lerna.json').version" 2> /dev/null)
    fi
    if [[ "$package_version" == "independent" ]]; then
      package_version="($package_version)"
    fi
  fi

  if [[ -f Cargo.toml ]] && spaceship::exists cargo; then
    # Handle missing field `version` in Cargo.toml.
    # `cargo pkgid` need Cargo.lock exists too. If it does't, do not show package version
    # https://github.com/spaceship-prompt/spaceship-prompt/pull/617
    local pkgid=$(cargo pkgid 2>&1)
    echo $pkgid | grep -q "error:" || package_version=${pkgid##*\#}
  fi

  if [[ -f pubspec.yaml ]] && spaceship::exists flutter; then
    if spaceship::exists ruby; then
      PUBSPEC_YAML_PARSE="pubspec = YAML::load(STDIN.read); puts pubspec['version']"
      package_version=$(cat pubspec.yaml | ruby -ryaml -e "${PUBSPEC_YAML_PARSE}")
    elif spaceship::exists flutter; then
      package_version=$(flutter pub deps | sed -n 3p | tr " " "\n" | sed -n 2p 2>/dev/null)
    fi
  fi

  [[ -z $package_version || "$package_version" == "null" || "$package_version" == "undefined" ]] && return

  spaceship::section \
    "$SPACESHIP_PACKAGE_COLOR" \
    "$SPACESHIP_PACKAGE_PREFIX" \
    "${SPACESHIP_PACKAGE_SYMBOL}v${package_version}" \
    "$SPACESHIP_PACKAGE_SUFFIX"
}
