#
# Nix-shell
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_NIX_SHELL_SHOW="${SPACESHIP_NIX_SHELL_SHOW=true}"
SPACESHIP_NIX_SHELL_NAMED_PREFIX="${SPACESHIP_NIX_SHELL_NAMED_PREFIX="in "}"
SPACESHIP_NIX_SHELL_PACKAGE_PREFIX="${SPACESHIP_NIX_SHELL_PACKAGE_PREFIX="with "}"
SPACESHIP_NIX_SHELL_SUFFIX="${SPACESHIP_NIX_SHELL_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_NIX_SHELL_SYMBOL=""
SPACESHIP_NIX_SHELL_COLOR="${SPACESHIP_NIX_SHELL_COLOR="green"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# NOTE: needs https://github.com/chisui/zsh-nix-shell to show name and packages
# from nix-shell environment

# Heavily inspired by:
# https://gist.github.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e#file-agnoster-nix-zsh-theme-L201

# nix-shell: currently running nix-shell
spaceship_nix_shell() {
  [[ $SPACESHIP_NIX_SHELL_SHOW == false ]] && return

  # Checks if shell is nix,
  [[ -z $IN_NIX_SHELL ]] && return

  # If initialized with `nix-shell -p [packages]`
  if [[ -n $NIX_SHELL_PACKAGES ]]; then
    local packageNames=""
    local packages=($NIX_SHELL_PACKAGES)

    # Get all active packages
    for package in $packages; do
      packageNames+="${package}"
    done

    # format output and set prefix
    output="$packageNames"
    prefix="$SPACESHIP_NIX_SHELL_PACKAGE_PREFIX"

  # Else, get name property from default.nix stdenvironment
  else
    local cleanName=${name#interactive-}
    cleanName=${cleanName%-environment}

    # format output and set prefix
    output="$cleanName"
    prefix="$SPACESHIP_NIX_SHELL_NAMED_PREFIX"
  fi

  spaceship::section \
    "$SPACESHIP_NIX_SHELL_COLOR" \
    "$prefix" \
    "$output" \
    "$SPACESHIP_NIX_SHELL_SUFFIX"
}
