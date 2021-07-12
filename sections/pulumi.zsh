#
# PULUMI Stack
#
# PULUMI automates the repetitive tasks of setting up cloud resources
# Link: https://www.pulumi.com/
#
# This section shows you the current stack and number of resources 
# Link: https://www.pulumi.com/docs/intro/concepts/stack/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_PULUMI_SHOW="${SPACESHIP_PULUMI_SHOW=true}"
SPACESHIP_PULUMI_PREFIX="${SPACESHIP_PULUMI_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_PULUMI_SUFFIX="${SPACESHIP_PULUMI_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_PULUMI_SYMBOL="${SPACESHIP_PULUMI_SYMBOL="🛠𝓅 "}"
SPACESHIP_PULUMI_COLOR="${SPACESHIP_PULUMI_COLOR="133"}"

# ------------------------------------------------------------------------------
# Section
# ----------------------------------------------- -------------------------------

spaceship_pulumi() {
  [[ $SPACESHIP_PULUMI_SHOW == false ]] && return

  spaceship::exists pulumi || return

  # Show PULUMI Stack when exists
  [[ -d .pulumi/stacks ]] || return

  local pulumi_stack=$(pulumi stack ls 2>/dev/null| sed -n -e '2p' |cut -f1 -d" "|sed s/\*// )
  [[ -z $pulumi_stack ]] && return

  spaceship::section \
    "$SPACESHIP_PULUMI_COLOR" \
    "$SPACESHIP_PULUMI_PREFIX" \
    "$SPACESHIP_PULUMI_SYMBOL$pulumi_stack" \
    "$SPACESHIP_PULUMI_SUFFIX"
}
