#
# Azure Cloud
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_AZURE_SHOW="${SPACESHIP_AZURE_SHOW=true}"
SPACESHIP_AZURE_PREFIX="${SPACESHIP_AZURE_PREFIX="az "}"
SPACESHIP_AZURE_SUFFIX="${SPACESHIP_AZURE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_AZURE_SYMBOL="${SPACESHIP_AZURE_SYMBOL="☁️  "}"
SPACESHIP_AZURE_COLOR="${SPACESHIP_AZURE_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Shows selected Azure CLI Context.
spaceship_azure() {
    [[ $SPACESHIP_AZURE_SHOW == false ]] && return

    # Check if the Azure CLI is installed
    spaceship::exists az || return
    # Check if we have the software that we need
    spaceship::exists jq || return
    spaceship::exists base64 || return
    ACCESS_TOKEN=$(cat $HOME/.azure/accessTokens.json | jq -r ". | sort_by(.expiresOn) | reverse | .[0].accessToken" | cut -d '.' -f 2 | base64 -d)
    if echo $ACCESS_TOKEN | jq -e ".exp" >/dev/null 2>&1; then
        ACCESS_TOKEN_EXPIRY=$(echo $ACCESS_TOKEN | jq -e ".exp")
    elif echo "$ACCESS_TOKEN]}" | jq -e ".exp" >/dev/null 2>&1; then
        ACCESS_TOKEN_EXPIRY=$(echo "$ACCESS_TOKEN]}" | jq -e ".exp")
    elif echo "$ACCESS_TOKEN}" | jq -e ".exp" >/dev/null 2>&1; then
        ACCESS_TOKEN_EXPIRY=$(echo "$ACCESS_TOKEN}" | jq -e ".exp")
    else
        return
    fi
    if [[ $(date +"%s") -gt $ACCESS_TOKEN_EXPIRY ]]; then 
        return
    fi
    AZURE_CONTEXT=$(cat $HOME/.azure/azureProfile.json | jq -r ".subscriptions[] | select(.isDefault == true) | .name")
    AZURE_CONTEXT_GROUP=$(cat $HOME/.azure/config | grep group | cut -d "=" -f 2 | cut -d " " -f 2)
    if [[ ! -z "${AZURE_CONTEXT_GROUP// }" ]]; then
        AZURE_CONTEXT="$AZURE_CONTEXT ($AZURE_CONTEXT_GROUP)"
    fi

    # Show prompt section
    spaceship::section \
        "$SPACESHIP_AZURE_COLOR" \
        "$SPACESHIP_AZURE_PREFIX" \
        "${SPACESHIP_AZURE_SYMBOL}$AZURE_CONTEXT" \
        "$SPACESHIP_AZURE_SUFFIX"
}
