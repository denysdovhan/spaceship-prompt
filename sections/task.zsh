#
# TaskWarrior
#
# TaskWarrior manages your TODO list from the command line
# Link: https://taskwarrior.org/
#
# ready count inspired from: https://blog.djy.io/taskwarrior-where-have-you-been-all-my-life/
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_TASK_SHOW="${SPACESHIP_TASK_SHOW=true}"
SPACESHIP_TASK_SYMBOL="${SPACESHIP_TASK_SYMBOL="☑"}"
SPACESHIP_TASK_COLOR="${SPACESHIP_TASK_COLOR="magenta"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show the number of tasks available in the task ready report
spaceship_task() {
  [[ $SPACESHIP_TASK_SHOW == false ]] && return

  # Check if task command is available for execution
  spaceship::exists task || return

  local 'task_count'

  if [[ -n $(task ready 2>/dev/null) ]]; then
    task_count=$(task ready | tail -n1 | awk '{print $1}')
  fi

  # Exit section if variable is empty
  [[ -z $task_count ]] && return

  # Display task section
  spaceship::section \
    "$SPACESHIP_TASK_COLOR" \
    "$SPACESHIP_TASK_SYMBOL $task_count " \
  }
