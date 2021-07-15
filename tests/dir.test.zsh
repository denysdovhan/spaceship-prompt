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
  SPACESHIP_PROMPT_ORDER=(dir)

  source spaceship.zsh
}

setUp() {
  SPACESHIP_DIR_SHOW=true
  SPACESHIP_DIR_PREFIX="in "
  SPACESHIP_DIR_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
  SPACESHIP_DIR_TRUNC=3
  SPACESHIP_DIR_TRUNC_REPO=true
  SPACESHIP_DIR_COLOR="cyan"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

tearDown() {
  unset SPACESHIP_DIR_SHOW
  unset SPACESHIP_DIR_PREFIX
  unset SPACESHIP_DIR_SUFFIX
  unset SPACESHIP_DIR_TRUNC
  unset SPACESHIP_DIR_TRUNC_REPO
  unset SPACESHIP_DIR_COLOR
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_dir_home() {
  cd ~

  local expected="%{%B%}in %{%b%}%{%B%F{$SPACESHIP_DIR_COLOR}%}%(4~||)%3~%{%b%f%}%{%B%} %{%b%}"
  prompt_spaceship_precmd; local actual="${__ss_unsafe[prompt]}"

  assertEquals "render dir" "$expected" "$actual"
}

test_dir_color() {
  SPACESHIP_DIR_COLOR=blue

  local expected="%{%B%}in %{%b%}%{%B%F{$SPACESHIP_DIR_COLOR}%}%(4~||)%3~%{%b%f%}%{%B%} %{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render dir with custom color" "$expected" "$actual"
}

test_dir_prefix() {
  SPACESHIP_DIR_PREFIX='prefix'
  SPACESHIP_DIR_SUFFIX=''

  local expected="%{%B%}$SPACESHIP_DIR_PREFIX%{%b%}%{%B%F{cyan}%}%(4~||)%3~%{%b%f%}%{%B%}$SPACESHIP_DIR_SUFFIX%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render dir with prefix" "$expected" "$actual"
}

test_dir_suffix() {
  SPACESHIP_DIR_PREFIX=''
  SPACESHIP_DIR_SUFFIX='suffix'

  local expected="%{%B%}$SPACESHIP_DIR_PREFIX%{%b%}%{%B%F{cyan}%}%(4~||)%3~%{%b%f%}%{%B%}$SPACESHIP_DIR_SUFFIX%{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render dir with suffix" "$expected" "$actual"
}

test_dir_trunc() {
  SPACESHIP_DIR_TRUNC=2

  local expected="%{%B%}in %{%b%}%{%B%F{cyan}%}%($((SPACESHIP_DIR_TRUNC+1))~||)%$SPACESHIP_DIR_TRUNC~%{%b%f%}%{%B%} %{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render truncated dir" "$expected" "$actual"
}

test_dir_trunc_git() {
  local REPO="$SHUNIT_TMPDIR/dir/trunc_git/dir1/dir2/dir3"
  mkdir -p $REPO/dir4/dir5

  cd $REPO
  command git init >/dev/null

  cd $REPO/dir4/dir5

  local expected="%{%B%}in %{%b%}%{%B%F{cyan}%}dir3/dir4/dir5%{%b%f%}%{%B%} %{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render truncated dir in git repos" "$expected" "$actual"
}

test_dir_trunc_git_submodule() {
  local FOLDER="$SHUNIT_TMPDIR/dir/trunc_git_submodule"
  local REPO="$FOLDER/dir1/dir2/dir3"
  local SUBMODULE="$FOLDER/dir1/dir2/dir4"

  mkdir -p $REPO
  mkdir -p $SUBMODULE

  cd $SUBMODULE
  command git init >/dev/null
  command touch sample.txt
  command git add sample.txt >/dev/null
  command git commit -m  "Add sample file" >/dev/null

  cd $REPO
  command git init >/dev/null
  command touch sample.txt
  command git add sample.txt >/dev/null
  command git commit -m "Add sample file" >/dev/null
  command git submodule add $SUBMODULE 2&>/dev/null

  cd dir4

  local expected="%{%B%}in %{%b%}%{%B%F{cyan}%}dir4%{%b%f%}%{%B%} %{%b%}"
  local actual=""
  prompt_spaceship_precmd; actual="${__ss_unsafe[prompt]}"

  assertEquals "render submodule dir in the git repo" "$expected" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source modules/shunit2/shunit2
