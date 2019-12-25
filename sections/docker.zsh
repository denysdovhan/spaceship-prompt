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
# Section
# ------------------------------------------------------------------------------

# Show current Docker version and connected machine
spaceship_docker() {
  [[ $SPACESHIP_DOCKER_SHOW == false ]] && return

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

  # Docker contexts can be set using either the DOCKER_CONTEXT environment variable
  # or the `docker context use` command. `docker context ls` will show the selected
  # context in both cases. But we are not interested in the local "default" context.
  local docker_context=$(docker context ls --format '{{if .Current}}{{if ne .Name "default"}}{{.Name}}{{end}}{{end}}' 2>/dev/null | tr -d '\n')

  # Show Docker status only for Docker-specific folders or when connected to external host
  [[ "$compose_exists" == true || -f Dockerfile || -f docker-compose.yml || -f /.dockerenv || -n $DOCKER_MACHINE_NAME || -n $DOCKER_HOST || -n $docker_context ]] || return

  # if docker daemon isn't running you'll get an error saying it can't connect
  local docker_version=$(docker version -f "{{.Server.Version}}" 2>/dev/null)
  [[ -z $docker_version ]] && return

  [[ $SPACESHIP_DOCKER_VERBOSE == false ]] && docker_version=${docker_version%-*}

  # Docker has three different ways to work on remote Docker hosts:
  #  1. docker-machine
  #  2. DOCKER_HOST environment variable
  #  3. docker context (new in Docker 19.03)
  local docker_host=''
  if [[ -n $DOCKER_MACHINE_NAME ]]; then
    docker_host=" via ($DOCKER_MACHINE_NAME)"
  fi

  if [[ -n $DOCKER_HOST ]]; then
    # Remove protocol (tcp://) and port number from displayed Docker host
    docker_host=" via ("$(basename $DOCKER_HOST | cut -d':' -f1)")"
  fi

  if [[ -n $docker_context ]]; then
    docker_host=" via ($docker_context)"
  fi

  spaceship::section \
    "$SPACESHIP_DOCKER_COLOR" \
    "$SPACESHIP_DOCKER_PREFIX" \
    "${SPACESHIP_DOCKER_SYMBOL}v${docker_version}${docker_host}" \
    "$SPACESHIP_DOCKER_SUFFIX"
}
