# ------------------------------------------------------------------------------
# WIDGETS
# Zsh widgets for advanced actions
# ------------------------------------------------------------------------------

# Lovingly borrowed from
# https://github.com/sindresorhus/pure/blob/master/pure.zsh
spaceship_reset_prompt_widget() {
  if [[ $CONTEXT == cont ]]; then
    # When the context is "cont", PS2 is active and calling
    # reset-prompt will have no effect on PS1, but it will
    # reset the execution context (%_) of PS2 which we don't
    # want. Unfortunately, we can't save the output of "%_"
    # either because it is only ever rendered as part of the
    # prompt, expanding in-place won't work.
    return
  fi

  zle && zle .reset-prompt
}
