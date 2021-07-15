#!/usr/bin/env zsh

# Required for shunit2 to run correctly
setopt shwordsplit
SHUNIT_PARENT=$0

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

oneTimeSetUp() {
  export TERM="xterm-256color"
  export PATH=$PWD/tests/stubs:$PATH

  SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_ORDER=(elm)

  source spaceship.zsh
}

setUp() {
  SPACESHIP_ELM_SHOW=true
  SPACESHIP_ELM_PREFIX="via "
  SPACESHIP_ELM_SUFFIX=""
  SPACESHIP_ELM_SYMBOL="🌳 "
  SPACESHIP_ELM_COLOR="cyan"

  cd $SHUNIT_TMPDIR
  touch test.elm
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

tearDown() {
  unset SPACESHIP_ELM_SHOW
  unset SPACESHIP_ELM_PREFIX
  unset SPACESHIP_ELM_SUFFIX
  unset SPACESHIP_ELM_SYMBOL
  unset SPACESHIP_ELM_COLOR
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_elm() {
  local expected="%{%B%}via %{%b%}%{%B%F{cyan}%}🌳 v0.20.0%{%b%f%}%{%B%}%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm" "$expected" "$actual"
}

test_elm_show_false() {
  SPACESHIP_ELM_SHOW=false

  local expected=""
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "don't render elm" "$expected" "$actual"
}

test_elm_files() {
  local expected="%{%B%}via %{%b%}%{%B%F{cyan}%}🌳 v0.20.0%{%b%f%}%{%B%}%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm when test.elm exists" "$expected" "$actual"

  rm test.elm
  touch elm.json

  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm when elm.json exists" "$expected" "$actual"

  rm elm.json
  touch elm-package.json

  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm when elm-package.json exists" "$expected" "$actual"

  rm elm-package.json
  mkdir elm-stuff

  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm when elm-stuff exists" "$expected" "$actual"

  rm -r elm-stuff

  local expected=""
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "don't render when no elm files are present" "$expected" "$actual"
}

test_elm_symbol() {
  SPACESHIP_ELM_SYMBOL="🌵 "

  local expected="%{%B%}via %{%b%}%{%B%F{cyan}%}🌵 v0.20.0%{%b%f%}%{%B%}%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm with custom symbol" "$expected" "$actual"
}

test_elm_prefix() {
  SPACESHIP_ELM_PREFIX='prefix'
  SPACESHIP_ELM_SUFFIX=''

  local expected="%{%B%}prefix%{%b%}%{%B%F{cyan}%}🌳 v0.20.0%{%b%f%}%{%B%}%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm with prefix" "$expected" "$actual"
}

test_elm_suffix() {
  SPACESHIP_ELM_PREFIX=''
  SPACESHIP_ELM_SUFFIX='suffix'

  local expected="%{%B%}%{%b%}%{%B%F{cyan}%}🌳 v0.20.0%{%b%f%}%{%B%}suffix%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render elm with suffix" "$expected" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source modules/shunit2/shunit2
