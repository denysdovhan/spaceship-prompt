#
# Ansible
#
# Ansible is an IT automation tool. It can configure systems, deploy software, and orchestrate more advanced IT tasks
# such as continuous deployments or zero downtime rolling updates.
# Link: https://docs.ansible.com/ansible/latest/index.html

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_ANSIBLE_SHOW="${SPACESHIP_ANSIBLE_SHOW=true}"
SPACESHIP_ANSIBLE_SHOW_VERSION="${SPACESHIP_ANSIBLE_SHOW_VERSION=false}"
SPACESHIP_ANSIBLE_PREFIX="${SPACESHIP_ANSIBLE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_ANSIBLE_SUFFIX="${SPACESHIP_ANSIBLE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_ANSIBLE_SYMBOL="${SPACESHIP_ANSIBLE_SYMBOL="🅐 "}"
SPACESHIP_ANSIBLE_COLOR="${SPACESHIP_ANSIBLE_COLOR="white"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show ansible status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
spaceship_ansible() {
  # If SPACESHIP_ANSIBLE_SHOW is false, don't show ansible section
  [[ $SPACESHIP_ANSIBLE_SHOW == false ]] && return

  # Show ansible section only when there are ansible-specific files in current
  # working directory.
  # Here glob qualifiers are used to check if files with specific extension are
  # present in directory. Read more about them here:
  # https://zsh.sourceforge.net/Doc/Release/Expansion.html
  [[ -f ansible.cfg || -f .ansible.cfg || -f $(echo ?(*.yml|*.yaml)([1]N^/)) && $(grep -m 1 -E "tasks|hosts|roles" $(echo ?(*.yml|*.yaml)) &> /dev/null) -eq 0 ]] || return

  # Retrieve ansible status and save it to variable
  [[ ${SPACESHIP_ANSIBLE_SHOW_VERSION} = true ]] && ansible_status=${$(ansible --version)[2]}

  # Display ansible section
  spaceship::section \
    "$SPACESHIP_ANSIBLE_COLOR" \
    "$SPACESHIP_ANSIBLE_PREFIX" \
    "$SPACESHIP_ANSIBLE_SYMBOL$ansible_status" \
    "$SPACESHIP_ANSIBLE_SUFFIX"
}
