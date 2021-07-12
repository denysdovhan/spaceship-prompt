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
  SPACESHIP_PROMPT_ORDER=(vi_mode)

  source spaceship.zsh
}

setUp() {
  SPACESHIP_VI_MODE_SHOW=""
  SPACESHIP_VI_MODE_PREFIX=""
  SPACESHIP_VI_MODE_SUFFIX=""
  SPACESHIP_VI_MODE_INSERT=""
  SPACESHIP_VI_MODE_NORMAL=""
  SPACESHIP_VI_MODE_COLOR=""
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

tearDown() {
  unset SPACESHIP_VI_MODE_SHOW
  unset SPACESHIP_VI_MODE_PREFIX
  unset SPACESHIP_VI_MODE_SUFFIX
  unset SPACESHIP_VI_MODE_INSERT
  unset SPACESHIP_VI_MODE_NORMAL
  unset SPACESHIP_VI_MODE_COLOR
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_vi_mode_hidden() {
  SPACESHIP_VI_MODE_SHOW=false

  local expected=""
  local actual="$(spaceship_prompt)"

  assertEquals "vi mode hidden" "$expected" "$actual"
}

test_vi_mode_shown() {
  SPACESHIP_VI_MODE_SHOW=true

  local expected="%{%B%}%{%b%}%{%B%f%}%{%b%f%}%{%B%}%{%b%}"
  local actual="$(spaceship_prompt)"

  assertEquals "vi mode shown" "$expected" "$actual"
}

test_vi_mode_prefix() {
  SPACESHIP_VI_MODE_SHOW=true
  SPACESHIP_VI_MODE_PREFIX="prefix"

  local expected="%{%B%}%{%b%}%{%B%f%}prefix%{%b%f%}%{%B%}%{%b%}"
  local actual="$(spaceship_prompt)"

  assertEquals "vi mode prefix" "$expected" "$actual"
}

test_vi_mode_suffix() {
  SPACESHIP_VI_MODE_SHOW=true
  SPACESHIP_VI_MODE_SUFFIX="suffix"

  local expected="%{%B%}%{%b%}%{%B%f%}%{%b%f%}%{%B%}suffix%{%b%}"
  local actual="$(spaceship_prompt)"

  assertEquals "vi mode suffix" "$expected" "$actual"
}

test_vi_mode_insert() {
  SPACESHIP_VI_MODE_SHOW=true
  SPACESHIP_VI_MODE_INSERT="[I]"
  KEYMAP="main"

  local expected="%{%B%}%{%b%}%{%B%f%}[I]%{%b%f%}%{%B%}%{%b%}"
  local actual="$(spaceship_prompt)"

  assertEquals "vi mode insert" "$expected" "$actual"
}

test_vi_mode_normal() {
  SPACESHIP_VI_MODE_SHOW=true
  SPACESHIP_VI_MODE_NORMAL="[N]"
  KEYMAP="vicmd"

  local expected="%{%B%}%{%b%}%{%B%f%}[N]%{%b%f%}%{%B%}%{%b%}"
  local actual="$(spaceship_prompt)"

  assertEquals "vi mode normal" "$expected" "$actual"
}

test_vi_mode_color() {
  SPACESHIP_VI_MODE_SHOW=true
  SPACESHIP_VI_MODE_COLOR="white"

  local expected="%{%B%}%{%b%}%{%B%F{white}%}%{%b%f%}%{%B%}%{%b%}"
  local actual="$(spaceship_prompt)"

  assertEquals "vi mode color" "$expected" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source modules/shunit2/shunit2
