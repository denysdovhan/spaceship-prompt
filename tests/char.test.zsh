#!/usr/bin/env zsh

# Required for shunit2 to run correctly
setopt shwordsplit
SHUNIT_PARENT=$0

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

oneTimeSetUp() {
  export TERM="xterm-256color"

  SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_ORDER=(char)

  source spaceship.zsh
}

setUp() {
  SPACESHIP_CHAR_PREFIX=""
  SPACESHIP_CHAR_SUFFIX=""
  SPACESHIP_CHAR_SYMBOL="➜ "
  SPACESHIP_CHAR_COLOR_SUCCESS="green"
  SPACESHIP_CHAR_COLOR_FAILURE="red"
  SPACESHIP_CHAR_COLOR_SECONDARY="yellow"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

tearDown() {
  unset SPACESHIP_CHAR_PREFIX
  unset SPACESHIP_CHAR_SUFFIX
  unset SPACESHIP_CHAR_SYMBOL
  unset SPACESHIP_CHAR_COLOR_SUCCESS
  unset SPACESHIP_CHAR_COLOR_FAILURE
  unset SPACESHIP_CHAR_COLOR_SECONDARY
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_char() {
  SPACESHIP_CHAR_COLOR_SUCCESS=blue
  local expected="%{%B%}%{%b%}%{%B%F{$SPACESHIP_CHAR_COLOR_SUCCESS}%}➜ %{%b%f%}%{%B%}%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render char" "$expected" "$actual"
}

test_char_failure() {
  SPACESHIP_CHAR_COLOR_FAILURE=yellow
  local expected="%{%B%}%{%b%}%{%B%F{$SPACESHIP_CHAR_COLOR_FAILURE}%}➜ %{%b%f%}%{%B%}%{%b%}"
  local actual=""
  command false # this command should exit with non-zero code
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render char with failure" "$expected" "$actual"
}

test_char_symbol() {
  SPACESHIP_CHAR_SYMBOL='-> '

  local expected="%{%B%}%{%b%}%{%B%F{green}%}$SPACESHIP_CHAR_SYMBOL%{%b%f%}%{%B%}%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render char with custom symbol" "$expected" "$actual"
}

test_char_prefix() {
  SPACESHIP_CHAR_PREFIX='prefix'
  SPACESHIP_CHAR_SUFFIX=''

  local expected="%{%B%}$SPACESHIP_CHAR_PREFIX%{%b%}%{%B%F{green}%}➜ %{%b%f%}%{%B%}$SPACESHIP_CHAR_SUFFIX%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render char with prefix" "$expected" "$actual"
}

test_char_suffix() {
  SPACESHIP_CHAR_PREFIX=''
  SPACESHIP_CHAR_SUFFIX='suffix'

  local expected="%{%B%}$SPACESHIP_CHAR_PREFIX%{%b%}%{%B%F{green}%}➜ %{%b%f%}%{%B%}$SPACESHIP_CHAR_SUFFIX%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render char with suffix" "$expected" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source modules/shunit2/shunit2
