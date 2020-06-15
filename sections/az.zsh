#
# Azure (az)
#
# The az Command Line Interface (CLI) is a unified tool to manage Microsoft
# Azure services. Link: https://github.com/Azure/azure-cli

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_AZ_SHOW="${SPACESHIP_AZ_SHOW=true}"
SPACESHIP_AZ_PREFIX="${SPACESHIP_AZ_PREFIX="using "}"
SPACESHIP_AZ_SUFFIX="${SPACESHIP_AZ_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_AZ_SYMBOL="${SPACESHIP_AZ_SYMBOL="☁️ "}"
SPACESHIP_AZ_COLOR="${SPACESHIP_AZ_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Shows active az subscription and default resource group
spaceship_az() {
  [[ $SPACESHIP_AZ_SHOW == false ]] && return

  # Check if the az cli is installed
  spaceship::exists az || return

  local default_group=$(command grep "group = .\+" ~/.azure/config 2> /dev/null | command sed 's/group = \(.\+\)/\1/g' 2> /dev/null)
  local subscription=$(command grep AzureCloud ~/.azure/clouds.config -A 1 2> /dev/null | command grep subscription 2> /dev/null | command sed 's/subscription = \(.\+\)/\1/g' 2> /dev/null)

  if [[ -n $default_group && -n $subscription ]]; then
      local az_status="$subscription/$default_group"
  elif [[ -n $default_group ]] ; then
      local az_status=$default_group
  elif [[ -n $subscription ]] ; then
      local az_status=$subscription
  fi

  [[ -n az_status ]] || return

  # Show prompt section
  spaceship::section \
    "$SPACESHIP_AZ_COLOR" \
    "$SPACESHIP_AZ_PREFIX" \
    "${SPACESHIP_AZ_SYMBOL}${az_status}" \
    "$SPACESHIP_AZ_SUFFIX"
}
