#
# Ocaml

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_OCAML_SHOW="${SPACESHIP_OCAML_SHOW=true}"
SPACESHIP_OCAML_PREFIX="${SPACESHIP_OCAML_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_OCAML_SUFFIX="${SPACESHIP_OCAML_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_OCAML_SYMBOL="${SPACESHIP_OCAML_SYMBOL="🐫  "}"
SPACESHIP_OCAML_COLOR="${SPACESHIP_OCAML_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of ocaml
spaceship_ocaml() {
  [[ $SPACESHIP_OCAML_SHOW == false ]] && return

  # Show versions only for ocaml-specific folders
  [[ -f dune* || \
     -f jbuild* || \
     -f .merlin || \
     -n *opam(#qN^/) || \
     -n *.ml(#qN^/) || \
     -n *.mli(#qN^/) ]] \
  || return

  local 'ocaml_version'

  if spaceship::exists opam; then
    ocaml_version=$(opam switch show)
  elif spaceship::exists ocaml; then
    ocaml_version=$(ocaml -vnum)
  else
    return
  fi

  [[ -z $ocaml_version || "${ocaml_version}" == "system" ]] && return

  spaceship::section \
    "$SPACESHIP_OCAML_COLOR" \
    "$SPACESHIP_OCAML_PREFIX" \
    "${SPACESHIP_OCAML_SYMBOL}${ocaml_version}" \
    "$SPACESHIP_OCAML_SUFFIX"
}
