#
# Spaceship ZSH
#
# Author: Denys Dovhan, denysdovhan.com
# License: MIT
# https://github.com/denysdovhan/spaceship-prompt

# Current version of Spaceship
# Useful for issue reporting
export SPACESHIP_VERSION='3.11.2'

# Common-used variable for new line separator
NEWLINE='
'

# Determination of Spaceship working directory
# https://git.io/vdBH7
if [[ -z "$SPACESHIP_ROOT" ]]; then
  if [[ "${(%):-%N}" == '(eval)' ]]; then
    if [[ "$0" == '-antigen-load' ]] && [[ -r "${PWD}/spaceship.zsh" ]]; then
      # Antigen uses eval to load things so it can change the plugin (!!)
      # https://github.com/zsh-users/antigen/issues/581
      export SPACESHIP_ROOT=$PWD
    else
      print -P "%F{red}You must set SPACESHIP_ROOT to work from within an (eval).%f"
      return 1
    fi
  else
    # Get the path to file this code is executing in; then
    # get the absolute path and strip the filename.
    # See https://stackoverflow.com/a/28336473/108857
    export SPACESHIP_ROOT=${${(%):-%x}:A:h}
  fi
fi

# ------------------------------------------------------------------------------
# CONFIGURATION
# The default configuration that can be overridden in .zshrc
# ------------------------------------------------------------------------------

if [ -z "$SPACESHIP_PROMPT_ORDER" ]; then
  SPACESHIP_PROMPT_ORDER=(
    time          # Time stampts section
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    hg            # Mercurial section (hg_branch  + hg_status)
    gradle        # Gradle section
    maven         # Maven section
    package       # Package version
    node          # Node.js section
    ruby          # Ruby section
    elm           # Elm section
    elixir        # Elixir section
    flutter       # Flutter section
    xcode         # Xcode section
    swift         # Swift section
    golang        # Go section
    php           # PHP section
    rust          # Rust section
    haskell       # Haskell Stack section
    julia         # Julia section
    docker        # Docker section
    aws           # Amazon Web Services section
    gcloud        # Google Cloud Platform section
    venv          # virtualenv section
    conda         # conda virtualenv section
    pyenv         # Pyenv section
    dotnet        # .NET section
    ember         # Ember.js section
    kubectl       # Kubectl context section
    terraform     # Terraform workspace section
    exec_time     # Execution time
    line_sep      # Line break
    battery       # Battery level and status
    vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
  )
fi

if [ -z "$SPACESHIP_RPROMPT_ORDER" ]; then
  SPACESHIP_RPROMPT_ORDER=(
    # empty by default
  )
fi

# PROMPT
SPACESHIP_PROMPT_ADD_NEWLINE="${SPACESHIP_PROMPT_ADD_NEWLINE=true}"
SPACESHIP_PROMPT_SEPARATE_LINE="${SPACESHIP_PROMPT_SEPARATE_LINE=true}"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="${SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false}"
SPACESHIP_PROMPT_PREFIXES_SHOW="${SPACESHIP_PROMPT_PREFIXES_SHOW=true}"
SPACESHIP_PROMPT_SUFFIXES_SHOW="${SPACESHIP_PROMPT_SUFFIXES_SHOW=true}"
SPACESHIP_PROMPT_DEFAULT_PREFIX="${SPACESHIP_PROMPT_DEFAULT_PREFIX="via "}"
SPACESHIP_PROMPT_DEFAULT_SUFFIX="${SPACESHIP_PROMPT_DEFAULT_SUFFIX=" "}"

# ------------------------------------------------------------------------------
# LIBS
# Spaceship utils/hooks/etc
# ------------------------------------------------------------------------------

# Load utils
source "$SPACESHIP_ROOT/lib/utils.zsh"

# load hooks
source "$SPACESHIP_ROOT/lib/hooks.zsh"

# load section utils
source "$SPACESHIP_ROOT/lib/section.zsh"

# ------------------------------------------------------------------------------
# SECTIONS
# Sourcing sections the prompt consists of
# ------------------------------------------------------------------------------

for section in $(spaceship::union $SPACESHIP_PROMPT_ORDER $SPACESHIP_RPROMPT_ORDER); do
  if [[ -f "$SPACESHIP_ROOT/sections/$section.zsh" ]]; then
    source "$SPACESHIP_ROOT/sections/$section.zsh"
  elif spaceship::defined "spaceship_$section"; then
    # Custom section is declared, nothing else to do
    continue
  else
    echo "Section '$section' was not loaded."
  fi
done

# ------------------------------------------------------------------------------
# BACKWARD COMPATIBILITY WARNINGS
# Show deprecation messages for options that are set, but not supported
# ------------------------------------------------------------------------------

spaceship::deprecated SPACESHIP_PROMPT_SYMBOL "Use %BSPACESHIP_CHAR_SYMBOL%b instead."
spaceship::deprecated SPACESHIP_BATTERY_ALWAYS_SHOW "Use %BSPACESHIP_BATTERY_SHOW='always'%b instead."
spaceship::deprecated SPACESHIP_BATTERY_CHARGING_SYMBOL "Use %BSPACESHIP_BATTERY_SYMBOL_CHARGING%b instead."
spaceship::deprecated SPACESHIP_BATTERY_DISCHARGING_SYMBOL "Use %BSPACESHIP_BATTERY_SYMBOL_DISCHARGING%b instead."
spaceship::deprecated SPACESHIP_BATTERY_FULL_SYMBOL "Use %BSPACESHIP_BATTERY_SYMBOL_FULL%b instead."

# ------------------------------------------------------------------------------
# PROMPTS
# An entry point of prompt
# ------------------------------------------------------------------------------

# PROMPT
# Primary (left) prompt
spaceship_prompt() {
  # Retrieve exit code of last command to use in exit_code
  # Must be captured before any other command in prompt is executed
  # Must be the very first line in all entry prompt functions, or the value
  # will be overridden by a different command execution - do not move this line!
  RETVAL=$?

  # Should it add a new line before the prompt?
  [[ $SPACESHIP_PROMPT_ADD_NEWLINE == true ]] && echo -n "$NEWLINE"
  spaceship::compose_prompt $SPACESHIP_PROMPT_ORDER
}

# $RPROMPT
# Optional (right) prompt
spaceship_rprompt() {
  # Retrieve exit code of last command to use in exit_code
  RETVAL=$?

  spaceship::compose_prompt $SPACESHIP_RPROMPT_ORDER
}

# PS2
# Continuation interactive prompt
spaceship_ps2() {
  # Retrieve exit code of last command to use in exit_code
  RETVAL=$?

  local char="${SPACESHIP_CHAR_SYMBOL_SECONDARY="$SPACESHIP_CHAR_SYMBOL"}"
  spaceship::section "$SPACESHIP_CHAR_COLOR_SECONDARY" "$char"
}

# ------------------------------------------------------------------------------
# SETUP
# Setup requirements for prompt
# ------------------------------------------------------------------------------

# Runs once when user opens a terminal
# All preparation before drawing prompt should be done here
prompt_spaceship_setup() {
  autoload -Uz vcs_info
  autoload -Uz add-zsh-hook

  # This variable is a magic variable used when loading themes with zsh's prompt
  # function. It will ensure the proper prompt options are set.
  prompt_opts=(cr percent sp subst)

  # Borrowed from promptinit, sets the prompt options in case the prompt was not
  # initialized via promptinit.
  setopt noprompt{bang,cr,percent,subst} "prompt${^prompt_opts[@]}"

  # Add exec_time hooks
  add-zsh-hook preexec spaceship_exec_time_preexec_hook
  add-zsh-hook precmd spaceship_exec_time_precmd_hook

  # Disable python virtualenv environment prompt prefix
  VIRTUAL_ENV_DISABLE_PROMPT=true

  # Configure vcs_info helper for potential use in the future
  add-zsh-hook precmd spaceship_exec_vcs_info_precmd_hook
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git*' formats '%b'

  # Expose Spaceship to environment variables
  PROMPT='$(spaceship_prompt)'
  PS2='$(spaceship_ps2)'
  RPS1='$(spaceship_rprompt)'
}

# ------------------------------------------------------------------------------
# ENTRY POINT
# An entry point of prompt
# ------------------------------------------------------------------------------

# Pass all arguments to the spaceship_setup function
prompt_spaceship_setup "$@"
