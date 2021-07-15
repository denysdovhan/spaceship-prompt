#
# Execution time
#
# Execution time of the last command.

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_EXEC_TIME_SHOW="${SPACESHIP_EXEC_TIME_SHOW=true}"
SPACESHIP_EXEC_TIME_PREFIX="${SPACESHIP_EXEC_TIME_PREFIX="took "}"
SPACESHIP_EXEC_TIME_SUFFIX="${SPACESHIP_EXEC_TIME_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_EXEC_TIME_COLOR="${SPACESHIP_EXEC_TIME_COLOR="yellow"}"
SPACESHIP_EXEC_TIME_ELAPSED="${SPACESHIP_EXEC_TIME_ELAPSED=2}"
SPACESHIP_EXEC_TIME_PRECISION="${SPACESHIP_EXEC_TIME_PRECISION=2}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_exec_time() {
  [[ $SPACESHIP_EXEC_TIME_SHOW == false ]] && return

  if (( SPACESHIP_EXEC_TIME_duration >= SPACESHIP_EXEC_TIME_ELAPSED )); then
    # Print time in human readable format
    # For that use `strftime` and convert
    # the duration (float) to an seconds
    # (integer).
    # See http://unix.stackexchange.com/a/89748
    local humanReadableDuration
    if (( SPACESHIP_EXEC_TIME_duration > 3600 )); then
      humanReadableDuration=$(TZ=GMT; strftime '%H:%M:%S' $(( int(rint(SPACESHIP_EXEC_TIME_duration)) )))
    elif (( SPACESHIP_EXEC_TIME_duration > 60 )); then
      humanReadableDuration=$(TZ=GMT; strftime '%M:%S' $(( int(rint(SPACESHIP_EXEC_TIME_duration)) )))
    else
      # If the command executed in seconds, round to desired precision and append "s"
      humanReadableDuration=$(printf %.${SPACESHIP_EXEC_TIME_PRECISION}f%s $SPACESHIP_EXEC_TIME_duration s)
    fi

    spaceship::section \
      "$SPACESHIP_EXEC_TIME_COLOR" \
      "$SPACESHIP_EXEC_TIME_PREFIX" \
      "$humanReadableDuration" \
      "$SPACESHIP_EXEC_TIME_SUFFIX"
  fi
}
