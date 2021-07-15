#!/usr/bin/env zsh

# Required for shunit2 to run correctly
setopt shwordsplit
SHUNIT_PARENT=$0

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

oneTimeSetUp() {
  export TERM="xterm-256color"

  source lib/utils.zsh
  source lib/section.zsh
  prompt_spaceship_setup
}

setUp() {
  SPACESHIP_PROMPT_PREFIXES_SHOW=true
  SPACESHIP_PROMPT_SUFFIXES_SHOW=true
}

tearDown() {
  unset SPACESHIP_PROMPT_PREFIXES_SHOW
  unset SPACESHIP_PROMPT_SUFFIXES_SHOW
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_section() {
  local color="cyan" content="content" prefix="prefix" suffix="suffix"

  local expected_none="%{%B%}%{%b%}%{%B%f%}%{%b%f%}%{%B%}%{%b%}"
  local actual_none=""
  actual_none="$(spaceship::section;echo ${__SS_DATA[section_result]})"

  assertEquals "render section without arguments" "$expected_none" "$actual_none"

  local expected_short="%{%B%}%{%b%}%{%B%F{$color}%}$content%{%b%f%}%{%B%}%{%b%}"
  local actual_short=""
  actual_short="$(spaceship::section $color $content;echo ${__SS_DATA[section_result]})"

  assertEquals "render short section" "$expected_short" "$actual_short"

  local expected_suffix="%{%B%}%{%b%}%{%B%F{$color}%}$content%{%b%f%}%{%B%}$suffix%{%b%}"
  local actual_suffix=""
  actual_suffix="$(spaceship::section $color $prefix $content $suffix;echo ${__SS_DATA[section_result]})"

  assertEquals "render full section with suffix" "$expected_suffix" "$actual_suffix"

  spaceship_prompt_opened=true
  local expected="%{%B%}$prefix%{%b%}%{%B%F{$color}%}$content%{%b%f%}%{%B%}$suffix%{%b%}"
  local actual=""
  actual="$(spaceship::section $color $prefix $content $suffix;echo ${__SS_DATA[section_result]})"

  assertEquals "render full section with prefix and suffix" "$expected" "$actual"
}

test_compose_prompt() {
  spaceship_foo() { __SS_DATA[section_result]='foo' }
  spaceship_bar() { __SS_DATA[section_result]='bar' }

  # set order of left sections
  __SS_DATA[prompt_sections]="foo bar "

  local expected="foobar"
  local actual=""
  spaceship::build_section_cache
  actual="${__ss_unsafe[prompt]}"

  assertEquals "render spaceship sections" "$expected" "$actual"

  # Section existence is only checked at setup and warnings are popped out from
  # spaceship::load_sections. The new generator just skip unfounded sections.
  __SS_DATA[prompt_sections]="foo bar baz"

  local expected_not_found="foobar"
  local actual_not_found=""
  spaceship::build_section_cache 2>/dev/null
  local actual_not_found="${__ss_unsafe[prompt]}"

  assertEquals "skip missing sections" "$expected_not_found" "$actual_not_found"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source modules/shunit2/shunit2
