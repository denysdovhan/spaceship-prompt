#!/usr/bin/env zsh

# Required for shunit2 to run correctly
setopt shwordsplit
SHUNIT_PARENT=$0

function setUp() {
  export TERM="xterm-256color"

  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_HOST_SHOW="always"
  SPACESHIP_PROMPT_ORDER=(host)

  autoload -U promptinit; promptinit
  prompt spaceship
}

function tearDown() {
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_HOST_SHOW
  unset SPACESHIP_PROMPT_ORDER
}

function testHostShow() {
  assertEquals "%{%B%}%{%b%}%{%B%F{blue}%}%m%{%b%f%}%{%B%} %{%b%}" "$(spaceship_prompt)"
}

function testHostShowFull() {
  SPACESHIP_HOST_SHOW_FULL=true

  assertEquals "%{%B%}%{%b%}%{%B%F{blue}%}%M%{%b%f%}%{%B%} %{%b%}" "$(spaceship_prompt)"

  unset SPACESHIP_HOST_SHOW_FULL
}

function testHostSsh() {
  SSH_CONNECTION=" "

  assertEquals "%{%B%}%{%b%}%{%B%F{green}%}%m%{%b%f%}%{%B%} %{%b%}" "$(spaceship_prompt)"

  unset SSH_CONNECTION
}


function testHostShowFullSsh() {
  SSH_CONNECTION=" "
  SPACESHIP_HOST_SHOW_FULL=true

  assertEquals "%{%B%}%{%b%}%{%B%F{green}%}%M%{%b%f%}%{%B%} %{%b%}" "$(spaceship_prompt)"

  unset SSH_CONNECTION
  unset SPACESHIP_HOST_SHOW_FULL
}


source shunit2/shunit2
