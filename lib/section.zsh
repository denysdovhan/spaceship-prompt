# Internal variable for checking if prompt is opened
spaceship_prompt_opened="$SPACESHIP_PROMPT_FIRST_PREFIX_SHOW"

# store result from spaceship::section
typeset -gAH __SS_DATA
__SS_DATA[section_result]=""

# Draw prompt section (bold is used as default)
# USAGE:
#   spaceship::section <color> [prefix] <content> [suffix]
spaceship::section() {
  local color prefix content suffix
  [[ -n $1 ]] && color="%F{$1}"  || color="%f"
  prefix="$2"
  content="$3"
  suffix="$4"

  [[ -z $3 && -z $4 ]] && content=$2 prefix=''

  local result=""

  result+="%{%B%}" # set bold
  if [[ $spaceship_prompt_opened == true ]] && [[ $SPACESHIP_PROMPT_PREFIXES_SHOW == true ]]; then
    result+="${prefix}"
  fi
  spaceship_prompt_opened=true
  result+="%{%b%}" # unset bold

  result+="%{%B$color%}" # set color
  result+="$content"     # section content
  result+="%{%b%f%}"     # unset color

  result+="%{%B%}" # reset bold, if it was diabled before
  if [[ $SPACESHIP_PROMPT_SUFFIXES_SHOW == true ]]; then
    result+="$suffix"
  fi
  result+="%{%b%}" # unset bold

  # pass the result out with the global variable
  __SS_DATA[section_result]="$result"
}

# Takes the result of the sections computation and echos it,
# so that ZSH-Async can grab it.
#
# @args
#   $1 string The command to execute
#   $* Parameters for the command
spaceship::async_wrapper() {
  local command="${1}"
  local result="${2}"

  __SS_DATA[section_result]=""
  shift 1
  ${command} "$@"
  echo -n "${result}${__SS_DATA[section_result]}"
}

# Build prompt cache from section functions
# @description
#   This function loops through the prompt elements and calls
#   the related section functions.
#
# @args
#   $1 string, prompt/rprompt, alignment info
spaceship::build_section_cache() {
  # Option EXTENDED_GLOB is set locally to force filename generation on
  # argument to conditions, i.e. allow usage of explicit glob qualifier (#q).
  # See the description of filename generation in
  # http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html
  setopt EXTENDED_GLOB LOCAL_OPTIONS

  local -a alignments=("prompt" "rprompt")
  local alignment
  local async section cache_key result

  [[ -n "$1" ]] && alignments=("$1")

  for alignment in "${alignments[@]}"; do
    [[ ${#__SS_DATA[${alignment}_sections]} == "0" ]] && continue

    for section in ${=__SS_DATA[${alignment}_sections]}; do
      spaceship::section_is_tagged_as "async" "${section}" && async=true || async=false

      cache_key="${alignment}::${section}"

      if ${async}; then
        async_job "spaceship_async_worker" "spaceship::async_wrapper" "spaceship_${section}" "${section}·|·${alignment}·|·"

        # Placeholder
        __ss_section_cache[${cache_key}]="${section}·|·${alignment}·|·${SPACESHIP_SECTION_PLACEHOLDER}"
      else
        # pre-empty result storage, assuming the section won't be display
        __SS_DATA[section_result]=""
        spaceship_${section}
        __ss_section_cache[${cache_key}]="${section}·|·${alignment}·|·${__SS_DATA[section_result]}"
      fi
    done
  done

  if [[ ${#alignments} == "2" ]]; then
    spaceship::render
  else
    # only render the corresponding side of the prompt
    spaceship::render "${alignment[1]}"
  fi
}

# Refresh a single item in the cache, and redraw the prompt
#
# @args
#   $1 - section name
#   $2 - boolean true if render the prompt after cache update
function spaceship::refresh_cache_item() {
  [[ -z $1 ]] && return 1

  local section="$1"
  local alignment
  local cache result

  if spaceship::section_in_use "${section}" "prompt"; then
    alignment="prompt"
  elif spaceship::section_in_use "${section}" "rprompt"; then
    alignment="rprompt"
  else
    # Unavailable section name
    return 1
  fi

  spaceship::section_is_tagged_as "async" "${section}" && async=true || async=false

  cache_key="${alignment}::${section}"

  if ${async}; then
    async_job "spaceship_async_worker" "spaceship::async_wrapper" "spaceship_${section}" "${section}·|·${alignment}·|·"

    # Placeholder
    __ss_section_cache[${cache_key}]="${section}·|·${alignment}·|·${SPACESHIP_SECTION_PLACEHOLDER}"
  else
    __SS_DATA[section_result]=""
    spaceship_${section}
    __ss_section_cache[${cache_key}]="${section}·|·${alignment}·|·${__SS_DATA[section_result]}"

    [[ $2 == "true" ]] && spaceship::render "$alignment"
  fi
}

# Exchange result of prompt_<section> function in the cache and
# trigger re-rendering of prompt.
#
# @args
#   $1 job name, e.g. the function passed to async_job
#   $2 return code
#   $3 resulting (stdout) output from job execution
#   $4 execution time, floating point e.g. 0.0076138973 seconds
#   $5 resulting (stderr) error output from job execution
#   $6 has next result in buffer (0 = buffer empty, 1 = yes)
spaceship::async_callback() {
  local job="$1" ret="$2" output="$3" exec_time="$4" err="$5" has_next="$6"
  local section_meta cache_key

  # ignore the async evals used to alter worker environment
  if [[ "${job}" == "[async/eval]" ]] || \
     [[ "${job}" == ";" ]] || \
     [[ "${job}" == "[async]" ]]; then
    return
  fi

  # split input $output into an array - see https://unix.stackexchange.com/a/28873
  section_meta=("${(@s:·|·:)output}") # split on delimiter "·|·" (@s:<delim>:)
  cache_key="${section_meta[2]}::${section_meta[1]}"

  # Skip prompt re-rendering if both placeholder and section content are empty,
  # or section cache is unchanged
  if [[ "$SPACESHIP_SECTION_PLACEHOLDER" == "${section_meta[3]}" ]] \
    || [[ "${__ss_section_cache[${cache_key}]}" == "$output" ]]; then
    return
  else
    __ss_section_cache[${cache_key}]="${output}"
  fi

  # Delay prompt updates if there's another result in the buffer, which
  # prevents strange states in ZLE
  [[ "$has_next" == "0" ]] && spaceship::async_render
}

# Spaceship Render function.
# Goes through cache and renders each entry.
#
# @args
#   $1 - prompt/rprompt
spaceship::render() {
  local RPROMPT_PREFIX RPROMPT_SUFFIX
  local -a alignments=("prompt" "rprompt")
  local -a section_meta
  local alignment section cache_key

  [[ -n $1 ]] && alignments=("$1")

  for alignment in "${alignments[@]}"; do
    [[ ${#__SS_DATA[${alignment}_sections]} == "0" ]] && continue

    # Reset prompt storage
    __ss_unsafe[$alignment]=""

    for section in ${=__SS_DATA[${alignment}_sections]}; do
      cache_key="${alignment}::${section}"
      section_meta=("${(@s:·|·:)${__ss_section_cache[$cache_key]}}")

      [[ -z "${section_meta[3]}" ]] && continue # Skip if section is empty

      __ss_unsafe[$alignment]+="${section_meta[3]}"
    done

    # left/right specific
    if [[ $alignment == "prompt" ]]; then
      # Allow iTerm integration to work
      [[ "${ITERM_SHELL_INTEGRATION_INSTALLED:-}" == "Yes" ]] \
        && __ss_unsafe[prompt]="%{$(iterm2_prompt_mark)%}${__ss_unsafe[prompt]}"

      local NEWLINE=$'\n'

      [[ "$SPACESHIP_PROMPT_ADD_NEWLINE" == true ]] \
        && __ss_unsafe[prompt]="$NEWLINE${__ss_unsafe[prompt]}"

      # By evaluating $__ss_unsafe[prompt] here in __ss_render we avoid
      # the evaluation of $PROMPT being interrupted.
      # For security $PROMPT is never set directly. This way the prompt render is
      # forced to evaluate the variable and the contents of $__ss_unsafe[prompt]
      # are never executed. The same applies to $RPROMPT.
      PROMPT='${__ss_unsafe[prompt]}'
    else
      if [[ "$SPACESHIP_RPROMPT_ADD_NEWLINE" != true ]]; then
        # The right prompt should be on the same line as the first line of the left
        # prompt. To do so, there is just a quite ugly workaround: Before zsh draws
        # the RPROMPT, we advise it, to go one line up. At the end of RPROMPT, we
        # advise it to go one line down. See:
        # http://superuser.com/questions/357107/zsh-right-justify-in-ps1
        RPROMPT_PREFIX='%{'$'\e[1A''%}' # one line up
        RPROMPT_SUFFIX='%{'$'\e[1B''%}' # one line down
        __ss_unsafe[rprompt]="${RPROMPT_PREFIX}${__ss_unsafe[rprompt]}${RPROMPT_SUFFIX}"
      fi
      RPROMPT='${__ss_unsafe[rprompt]}'
    fi
  done
}

spaceship::async_render() {
  spaceship::render "$@"

  # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
  # https://github.com/sorin-ionescu/prezto/issues/1026
  # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
  zle .reset-prompt && zle -R
}

# PS2
# Continuation interactive prompt
spaceship_ps2() {
  local char="${SPACESHIP_CHAR_SYMBOL_SECONDARY="$SPACESHIP_CHAR_SYMBOL"}"
  spaceship::section "$SPACESHIP_CHAR_COLOR_SECONDARY" "$char"
  echo -n "${__SS_DATA[section_result]}"
}

# ------------------------------------------------------------------------------
# SETUP
# Setup requirements for prompt
# ------------------------------------------------------------------------------

# Runs once when user opens a terminal
# All preparation before drawing prompt should be done here
prompt_spaceship_setup() {
  # Global section cache
  typeset -gAh __ss_section_cache=()

  # __ss_unsafe must be a global variable, because we set
  # PROMPT='$__ss_unsafe[left]', so without letting ZSH
  # expand this value (single quotes). This is a workaround
  # to avoid double expansion of the contents of the PROMPT.
  typeset -gAh __ss_unsafe=()

  # The value below was set to better support 32-bit CPUs.
  # It's the maximum _signed_ integer value on 32-bit CPUs.
  # Please don't change it until 19 January of 2038. ;)

  # Disable false display of command execution time
  SPACESHIP_EXEC_TIME_start=0x7FFFFFFF

  # This variable is a magic variable used when loading themes with zsh's prompt
  # function. It will ensure the proper prompt options are set.
  prompt_opts=(cr percent sp subst)

  # Borrowed from promptinit, sets the prompt options in case the prompt was not
  # initialized via promptinit.
  setopt noprompt{bang,cr,percent,subst} "prompt${^prompt_opts[@]}"

  # initialize timing functions
  zmodload zsh/datetime

  # Initialize math functions
  zmodload zsh/mathfunc

  # initialize hooks
  autoload -Uz add-zsh-hook

  add-zsh-hook precmd prompt_spaceship_precmd

  # Add exec_time hooks
  add-zsh-hook preexec prompt_spaceship_preexec

  # hook into chpwd for bindkey support
  add-zsh-hook chpwd prompt_spaceship_chpwd

  # Disable python virtualenv environment prompt prefix
  VIRTUAL_ENV_DISABLE_PROMPT=true

  # Expose Spaceship to environment variables
  PS2='$(spaceship_ps2)'
}

# This function removes spaceship hooks and resets the prompts.
prompt_spaceship_teardown() {
  # prompt hooks
  add-zsh-hook -D precmd  prompt_spaceship\*
  add-zsh-hook -D preexec prompt_spaceship\*
  add-zsh-hook -D chpwd   prompt_spaceship\*

  # reset prompt according to prompt_default_setup
  # +h, override the -h attr given to global special params
  local +h PS1='%m%# '
  local +h PS2='%_> '
  local +h PS3='?# '
  local +h PS4='+%N:%i> '
  unset RPS1 RPS2 RPROMPT RPROMPT2
  prompt_opts=( cr percent sp )

  unset __ss_section_cache
  unset __ss_unsafe
}
