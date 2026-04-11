#!/bin/zsh

setopt autocd autopushd pushdminus pushdsilent pushdtohome extendedglob globdots noclobber normstarsilent

alias -- -='cd -'
alias dirh='dirs -v'

_dotdot=".."
for _index in {1..9}; do
alias "$_index"="cd -${_index}"      # dirstack aliases (eg: "2"="cd -2")
alias -g "..${_index}"="${_dotdot}"  # backref aliases (eg: "..3"="../../..")
_dotdot+="/.."
done
unset _dotdot _index

function cd {
  if (( $+commands[eza] )); then
    builtin cd "$@" && eza -a --icons
  else
    builtin cd "$@" && ls -ah --color
  fi
}

function up {
  local parents="${1:-1}"
  if [[ ! "$parents" -gt 0 ]]; then
    echo >&2 "usage: up [<num>]"
    return 1
  fi
  local dotdots=".."
  while (( --parents )); do
    dotdots+="/.."
  done
  cd "$dotdots"
}

DIRSTACKFILE="$XDG_DATA_HOME/zsh/zsh_dirstack"
DIRSTACKSIZE=30

[[ -d "${DIRSTACKFILE:h}" ]] || mkdir -p "${DIRSTACKFILE:h}"
[[ -f "$DIRSTACKFILE" ]] || touch "$DIRSTACKFILE"

if [[ -r "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
  tmpstack=("${(@f)"$(< "$DIRSTACKFILE")"}")

  if [[ -n "$WORKDIR_SET" ]]; then
    dirstack=("${tmpstack[@]}")
  else
    dirstack=("${tmpstack[@]:1}")
    [[ -d "${tmpstack[1]}" ]] && cd -q "${tmpstack[1]}"
  fi
fi

chpwd_dirstackfile() {
  [[ -w "$DIRSTACKFILE" ]] && print -l "$PWD" "${(u)dirstack[@]}" >| "$DIRSTACKFILE"
}

autoload -Uz add-zsh-hook && add-zsh-hook -Uz chpwd chpwd_dirstackfile
