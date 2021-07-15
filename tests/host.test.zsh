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
  SPACESHIP_PROMPT_ORDER=(host)

  source spaceship.zsh
}

setUp() {
  SPACESHIP_HOST_SHOW=true
  SPACESHIP_HOST_SHOW_FULL=false
  SPACESHIP_HOST_PREFIX="at "
  SPACESHIP_HOST_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
  SPACESHIP_HOST_COLOR="blue"
  SPACESHIP_HOST_COLOR_SSH="green"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

tearDown() {
  unset SPACESHIP_HOST_SHOW
  unset SPACESHIP_HOST_SHOW_FULL
  unset SPACESHIP_HOST_PREFIX
  unset SPACESHIP_HOST_SUFFIX
  unset SPACESHIP_HOST_COLOR
  unset SPACESHIP_HOST_COLOR_SSH
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_host() {
  SPACESHIP_HOST_SHOW=true
  unset SSH_CONNECTION
  assertEquals "do not render host by default" "" "$actual"
}

test_host_show() {
  local expected="%{%B%}at %{%b%}%{%B%F{$SPACESHIP_HOST_COLOR}%}%m%{%b%f%}%{%B%} %{%b%}"
  local expected_full="%{%B%}at %{%b%}%{%B%F{$SPACESHIP_HOST_COLOR}%}%M%{%b%f%}%{%B%} %{%b%}"
  local expected_ssh="%{%B%}at %{%b%}%{%B%F{$SPACESHIP_HOST_COLOR_SSH}%}%m%{%b%f%}%{%B%} %{%b%}"
  local expected_ssh_full="%{%B%}at %{%b%}%{%B%F{$SPACESHIP_HOST_COLOR_SSH}%}%M%{%b%f%}%{%B%} %{%b%}"
  local actual=""

  SPACESHIP_HOST_SHOW=true

  SSH_CONNECTION=''
  SPACESHIP_HOST_SHOW_FULL=false
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=true, SSH=false, FULL=false" "" "$actual"

  SPACESHIP_HOST_SHOW_FULL=true
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=true, SSH=false, FULL=true" "" "$actual"

  SSH_CONNECTION='ssh'
  SPACESHIP_HOST_SHOW_FULL=false
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=true, SSH=true, FULL=false" "$expected_ssh" "$actual"

  SPACESHIP_HOST_SHOW_FULL=true
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=true, SSH=true, FULL=true" "$expected_ssh_full" "$actual"

  SPACESHIP_HOST_SHOW=always

  SSH_CONNECTION='ssh'
  SPACESHIP_HOST_SHOW_FULL=false
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=always, SSH=true, FULL=false" "$expected_ssh" "$actual"

  SPACESHIP_HOST_SHOW_FULL=true
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=always, SSH=true, FULL=true" "$expected_ssh_full" "$actual"

  SSH_CONNECTION=''
  SPACESHIP_HOST_SHOW_FULL=false
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=always, SSH=false, FULL=false" "$expected" "$actual"

  SPACESHIP_HOST_SHOW_FULL=true
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=always, SSH=false, FULL=true" "$expected_full" "$actual"

  SPACESHIP_HOST_SHOW=false

  SSH_CONNECTION='ssh'
  SPACESHIP_HOST_SHOW_FULL=false
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=false, SSH=true, FULL=false" "" "$actual"

  SPACESHIP_HOST_SHOW_FULL=true
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=false, SSH=true, FULL=true" "" "$actual"

  SSH_CONNECTION=''
  SPACESHIP_HOST_SHOW_FULL=false
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=false, SSH=false, FULL=false" "" "$actual"

  SPACESHIP_HOST_SHOW_FULL=true
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"
  assertEquals "SHOW=false, SSH=false, FULL=true" "" "$actual"

  unset SPACESHIP_HOST_SHOW_FULL
  unset SSH_CONNECTION
}

test_host_color() {
  SPACESHIP_HOST_SHOW=always # force user display
  SPACESHIP_HOST_COLOR=blue

  local expected="%{%B%}at %{%b%}%{%B%F{$SPACESHIP_HOST_COLOR}%}%m%{%b%f%}%{%B%} %{%b%}"
  prompt_spaceship_precmd
  local actual="${__ss_unsafe[prompt]}"

  assertEquals "render host with custom color" "$expected" "$actual"
}

test_host_prefix() {
  SPACESHIP_HOST_SHOW=always # force user display
  SPACESHIP_HOST_PREFIX='prefix'
  SPACESHIP_HOST_SUFFIX=''

  local expected="%{%B%}$SPACESHIP_HOST_PREFIX%{%b%}%{%B%F{blue}%}%m%{%b%f%}%{%B%}$SPACESHIP_HOST_SUFFIX%{%b%}"
  prompt_spaceship_precmd
  local actual="${__ss_unsafe[prompt]}"

  assertEquals "render host with prefix" "$expected" "$actual"
}

test_host_suffix() {
  SPACESHIP_HOST_SHOW=always # force user display
  SPACESHIP_HOST_PREFIX=''
  SPACESHIP_HOST_SUFFIX='suffix'

  local expected="%{%B%}$SPACESHIP_HOST_PREFIX%{%b%}%{%B%F{blue}%}%m%{%b%f%}%{%B%}$SPACESHIP_HOST_SUFFIX%{%b%}"
  prompt_spaceship_precmd
  local actual="${__ss_unsafe[prompt]}"

  assertEquals "render host with suffix" "$expected" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source modules/shunit2/shunit2
