# ------------------------------------------------------------------------------
# HOOKS
# Zsh hooks for advanced actions
# custom hooks for sections
# ------------------------------------------------------------------------------

# TODO: Let sections register their own hooks via `spaceship::register_hook`

spaceship_preexec_hook() {
  spaceship_exec_time_preexec_hook

  async_flush_jobs spaceship
}

spaceship_precmd_hook() {
  spaceship_start_async_tasks

  spaceship_exec_time_precmd_hook
}

spaceship_start_async_tasks() {
  if [[ "${SPACESHIP_ASYNC_init:-0}" = 0 ]]
  then
    # Create async worker
    async_start_worker spaceship -u -n
    async_register_callback spaceship spaceship_async_callback
    typeset -g SPACESHIP_ASYNC_init=1
  fi

  # Register async jobs
  async_job spaceship spaceship_async_git_branch "$PWD"
}

spaceship_async_callback() {
  local job="$1" ret="$2" output="$3"
  [[ "$ret" = 0 ]] && "${job}_callback" "$output"
}

# vcs_info hook
spaceship_exec_vcs_info_precmd_hook() {
  [[ $SPACESHIP_GIT_BRANCH_SHOW == false ]] && return
  vcs_info
}
