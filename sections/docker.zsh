#
# Docker
#
# Docker automates the repetitive tasks of setting up development environments
# Link: https://www.docker.com

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_DOCKER_SHOW="${SPACESHIP_DOCKER_SHOW=true}"
SPACESHIP_DOCKER_PREFIX="${SPACESHIP_DOCKER_PREFIX="on "}"
SPACESHIP_DOCKER_SUFFIX="${SPACESHIP_DOCKER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_DOCKER_SYMBOL="${SPACESHIP_DOCKER_SYMBOL="🐳 "}"
SPACESHIP_DOCKER_COLOR="${SPACESHIP_DOCKER_COLOR="cyan"}"
SPACESHIP_DOCKER_VERBOSE="${SPACESHIP_DOCKER_VERBOSE=false}"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/sections/docker_context.zsh"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current Docker version and connected machine
spaceship_docker() {
  [[ $SPACESHIP_DOCKER_SHOW == false ]] && return

  # Check if podman is used instead of docker
  spaceship::exists podman || return 
  if [ $? -eq 0 ]; then
    PODMAN=true
  fi
  spaceship::exists docker || return

  # Better support for docker environment vars: https://docs.docker.com/compose/reference/envvars/
  local compose_exists=false
  if [[ -n "$COMPOSE_FILE" ]]; then
    # Use COMPOSE_PATH_SEPARATOR or colon as default
    local separator=${COMPOSE_PATH_SEPARATOR:-":"}

    # COMPOSE_FILE may have several filenames separated by colon, test all of them
    local filenames=("${(@ps/$separator/)COMPOSE_FILE}")

    for filename in $filenames; do
      if [[ ! -f $filename ]]; then
        compose_exists=false
        break
      fi
      compose_exists=true
    done

    # Must return if COMPOSE_FILE is present but invalid
    [[ "$compose_exists" == false ]] && return
  fi

  local docker_context="$(spaceship_docker_context)"

  # Show Docker status only for Docker-specific folders or when connected to external host
  [[ "$compose_exists" == true || -f Dockerfile || -f docker-compose.yml || -f /.dockerenv || -n $docker_context ]] || return

  if [ $PODMAN ]; then
    local docker_version=$(podman version --format "{{.Version}}" 2>/dev/null)
  else
    # if docker daemon isn't running you'll get an error saying it can't connect
    local docker_version=$(docker version -f "{{.Server.Version}}" 2>/dev/null)
  fi
  [[ -z $docker_version ]] && return

  [[ $SPACESHIP_DOCKER_VERBOSE == false ]] && docker_version=${docker_version%-*}

  spaceship::section \
    "$SPACESHIP_DOCKER_COLOR" \
    "$SPACESHIP_DOCKER_PREFIX" \
    "${SPACESHIP_DOCKER_SYMBOL}v${docker_version}${docker_context}" \
    "$SPACESHIP_DOCKER_SUFFIX"
}
