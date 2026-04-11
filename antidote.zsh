#!/bin/zsh

: ${ANTIDOTE_HOME:=${XDG_CACHE_HOME:-$HOME/.cache}/antidote}
ANTIDOTE_REPO=$ANTIDOTE_HOME/github.com/mattmc3/antidote

zstyle ':antidote:home' path "$ANTIDOTE_HOME"
zstyle ':antidote:repo' path "$ANTIDOTE_REPO"
zstyle ':antidote:plugin:*' defer-options -p
zstyle ':antidote:*' zcompile yes

[[ -d $ANTIDOTE_REPO ]] ||
  git clone https://github.com/mattmc3/antidote "$ANTIDOTE_REPO"

source "$ANTIDOTE_REPO"/antidote.zsh
antidote load
