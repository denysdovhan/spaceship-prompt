#
# OCaml
#
# OCaml is an industrial strength programming language supporting functional,
# imperative and object-oriented styles
# Link: https://ocaml.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_OCAML_SHOW="${SPACESHIP_OCAML_SHOW=true}"
SPACESHIP_OCAML_PREFIX="${SPACESHIP_OCAML_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_OCAML_SUFFIX="${SPACESHIP_OCAML_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_OCAML_SYMBOL="${SPACESHIP_OCAML_SYMBOL="🐫 "}"
SPACESHIP_OCAML_COLOR="${SPACESHIP_OCAML_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of OCaml
spaceship_ocaml() {
  [[ $SPACESHIP_OCAML_SHOW == false ]] && return

  # Show OCaml status only for OCaml/Reason-specific folders
  [[ -n *.opam(#qN^/) || \
     -d _opam || \
     -d esy.lock || \
     -n dune*(#qN^/) || \
     -n jbuild*(#qN^/) || \
     -f .merlin || \
     -n *.{ml,mli,re,rei}(#qN^/)
  ]] || return

  local 'ocaml_version'

  if spaceship::exists esy && $(esy true 2>/dev/null); then
    ocaml_version=$(esy ocaml -vnum)
  elif spaceship::exists ocaml; then
    ocaml_version=$(ocaml -vnum)
  else
    return
  fi

  # Add 'v' before OCaml version that starts with a number
  [[ "${ocaml_version}" =~ ^[0-9].+$ ]] && ocaml_version="v${ocaml_version}"

  spaceship::section \
    "$SPACESHIP_OCAML_COLOR" \
    "$SPACESHIP_OCAML_PREFIX" \
    "${SPACESHIP_OCAML_SYMBOL}${ocaml_version}" \
    "$SPACESHIP_OCAML_SUFFIX"
}
