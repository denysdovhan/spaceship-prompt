#
# Terraform Workspaces
#
# Terraform automates the repetitive tasks of setting up cloud resources
# Link: https://www.terraform.io
#
# This section shows you the current Terraform workspace
# Link: https://www.terraform.io/docs/state/workspaces.html

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_TERRAFORM_SHOW="${SPACESHIP_TERRAFORM_SHOW=true}"
SPACESHIP_TERRAFORM_PREFIX="${SPACESHIP_TERRAFORM_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_TERRAFORM_SUFFIX="${SPACESHIP_TERRAFORM_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_TERRAFORM_SYMBOL="${SPACESHIP_TERRAFORM_SYMBOL="🛠 "}"
SPACESHIP_TERRAFORM_COLOR="${SPACESHIP_TERRAFORM_COLOR="105"}"

# ------------------------------------------------------------------------------
# Section
# ----------------------------------------------- -------------------------------

spaceship_terraform() {
  [[ $SPACESHIP_TERRAFORM_SHOW == false ]] && return

  spaceship::exists terraform || return

  # Show Terraform Workspaces when exists


    [[ -f .terraform/environment ]] || return
    if [[ $TF_WORKSPACE ]] then
        # get workspace from TF_WORKSPACE
        local terraform_workspace=$TF_WORKSPACE
    else
        # get workspace from .terraform/environment file
        local terraform_workspace=$(<.terraform/environment)
    fi

  [[ -z $terraform_workspace ]] && return

  spaceship::section \
    "$SPACESHIP_TERRAFORM_COLOR" \
    "$SPACESHIP_TERRAFORM_PREFIX" \
    "$SPACESHIP_TERRAFORM_SYMBOL$terraform_workspace" \
    "$SPACESHIP_TERRAFORM_SUFFIX"
}
