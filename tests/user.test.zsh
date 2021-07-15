#!/usr/bin/env zsh

# Required for shunit2 to run correctly
setopt shwordsplit
SHUNIT_PARENT=$0

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

oneTimeSetUp() {
  export TERM="xterm-256color"

  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
  SPACESHIP_PROMPT_ORDER=(user)

  source spaceship.zsh
}

setUp() {
  SPACESHIP_USER_SHOW=true
  SPACESHIP_USER_PREFIX="with "
  SPACESHIP_USER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
  SPACESHIP_USER_COLOR="yellow"
  SPACESHIP_USER_COLOR_ROOT="red"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

tearDown() {
  unset SPACESHIP_USER_SHOW
  unset SPACESHIP_USER_PREFIX
  unset SPACESHIP_USER_SUFFIX
  unset SPACESHIP_USER_COLOR
  unset SPACESHIP_USER_COLOR_ROOT
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_user() {
  local _user_="$USER"
  USER='tests'

  local expected="%{%B%}with %{%b%}%{%B%F{yellow}%}%n%{%b%f%}%{%B%} %{%b%}"
  prompt_spaceship_precmd; local actual="${__ss_unsafe[prompt]}"

  assertEquals "render user when needed" "$expected" "$actual"

  USER=$_user_
}

test_user_show() {
  local expected="%{%B%}with %{%b%}%{%B%F{yellow}%}%n%{%b%f%}%{%B%} %{%b%}"
  local actual=""

  SPACESHIP_USER_SHOW=true
  SSH_CONNECTION=''
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=true, SSH=false" "" "$actual"
  SSH_CONNECTION='ssh'
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=true, SSH=true" "$expected" "$actual"

  SPACESHIP_USER_SHOW=always
  SSH_CONNECTION=''
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=always, SSH=false" "$expected" "$actual"
  SSH_CONNECTION='ssh'
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=always, SSH=true" "$expected" "$actual"

  SPACESHIP_USER_SHOW=false
  SSH_CONNECTION=''
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=false, SSH=false" "" "$actual"
  SSH_CONNECTION='ssh'
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=false, SSH=true" "" "$actual"

  SPACESHIP_USER_SHOW=needed
  SSH_CONNECTION=''
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=needed, SSH=false" "" "$actual"
  SSH_CONNECTION='ssh'
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=needed, SSH=true" "" "$actual"

  unset SSH_CONNECTION
}

test_user_color() {
  SPACESHIP_USER_SHOW=always # force user display
  SPACESHIP_USER_COLOR=green

  local expected="%{%B%}with %{%b%}%{%B%F{$SPACESHIP_USER_COLOR}%}%n%{%b%f%}%{%B%} %{%b%}"
  prompt_spaceship_precmd; local actual="${__ss_unsafe[prompt]}"

  assertEquals "render user with custom color" "$expected" "$actual"
}

test_user_prefix() {
  SPACESHIP_USER_SHOW=always # force user display
  SPACESHIP_USER_PREFIX='prefix'
  SPACESHIP_USER_SUFFIX=''

  local expected="%{%B%}$SPACESHIP_USER_PREFIX%{%b%}%{%B%F{yellow}%}%n%{%b%f%}%{%B%}$SPACESHIP_USER_SUFFIX%{%b%}"
  prompt_spaceship_precmd; local actual="${__ss_unsafe[prompt]}"

  assertEquals "render user with prefix" "$expected" "$actual"
}

test_user_suffix() {
  SPACESHIP_USER_SHOW=always # force user display
  SPACESHIP_USER_PREFIX=''
  SPACESHIP_USER_SUFFIX='suffix'

  local expected="%{%B%}$SPACESHIP_USER_PREFIX%{%b%}%{%B%F{yellow}%}%n%{%b%f%}%{%B%}$SPACESHIP_USER_SUFFIX%{%b%}"
  prompt_spaceship_precmd; local actual="${__ss_unsafe[prompt]}"

  assertEquals "render user with suffix" "$expected" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source modules/shunit2/shunit2
