#
# Package
#
# Current package version.
# These package managers supported:
#   * NPM
#   * Cargo
#   * Python versioning

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
  local 'package_version'

  if [[ -f package.json ]] && spaceship::exists npm; then
    if spaceship::exists jq; then
      package_version=$(jq -r '.version' package.json 2>/dev/null)
    elif spaceship::exists python; then
      package_version=$(python -c "import json; print(json.load(open('package.json'))['version'])" 2>/dev/null)
    elif spaceship::exists node; then
      package_version=$(node -p "require('./package.json').version" 2> /dev/null)
    fi
  fi

  if [[ -f Cargo.toml ]] && spaceship::exists cargo; then
    # Handle missing field `version` in Cargo.toml.
    # `cargo pkgid` need Cargo.lock exists too. If it does't, do not show package version
    # https://github.com/denysdovhan/spaceship-prompt/pull/617
    local pkgid=$(cargo pkgid 2>&1)
    echo $pkgid | grep -q "error:" || package_version=${pkgid##*\#}
  fi

  # We only need to try python if no package version has been found yet
  if [[ -z $package_version ||
          "$package_version" == "null" ||
          "$package_version" == "undefined" ]] &&
          spaceship::exists python; then
    # The modern way of verifying python package version is using pkg_resources
    # The docs for pkg_resources can be found at:
    # https://setuptools.readthedocs.io/en/latest/pkg_resources.html
    # 
    # spaceship will try to get your package version using the current directory name or git root.
    # If the package is not found, it will not show any version.
    local package_name="os.path.abspath(os.curdir)"
    local package_root="."
    local should_find_package=true

    # If we are in a git repo, we should use the basename of the root of the repo
    if spaceship::exists git && 
              [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]] ; then
      package_root=$(git rev-parse --show-toplevel 2> /dev/null)
      package_name="\\\"$package_root\\\""
      # Even if we are in a git repo, we still need to have either setup.py or pyproject.toml
      # Otherwise skip finding a package.
      if [[ ! -f "$package_root/setup.py" ]] && [[ ! -f "$package_root/pyproject.toml" ]]; then
        should_find_package=false
      fi
    else
      # Otherwise if the current directory has either setup.py or pyproject.toml,
      # use that, otherwise just skip finding a package.
      if [[ ! -f "setup.py" ]] && [[ ! -f "pyproject.toml" ]]; then
        should_find_package=false
      fi
    fi

    # If our conditions have been met, find the package version
    if [[ should_find_package ]]; then
      local code="exec(\"import pkg_resources\nimport os\n"
      code+="try:\n"
      code+="    package_name = os.path.basename($package_name)\n"
      code+="    print(pkg_resources.get_distribution(package_name).version)\n"
      code+="except (pkg_resources.DistributionNotFound, pkg_resources.RequirementParseError):\n"
      code+="    print(\\\"error: failed to import package\\\")\")"

      local pkgid=$(cd $package_root && python -c "$code")
      echo $pkgid | grep -q "error:" || package_version=${pkgid##*\#}
    fi
  fi

  [[ -z $package_version || "$package_version" == "null" || "$package_version" == "undefined" ]] && return

  spaceship::section \
    "$SPACESHIP_PACKAGE_COLOR" \
    "$SPACESHIP_PACKAGE_PREFIX" \
    "${SPACESHIP_PACKAGE_SYMBOL}v${package_version}" \
    "$SPACESHIP_PACKAGE_SUFFIX"
}
