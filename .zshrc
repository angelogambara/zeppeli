#!/bin/zsh

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${ZDOTDIR:=$XDG_CONFIG_DIR/zsh}"

for xdg in \
  XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME \
  XDG_STATE_HOME ZDOTDIR
do
  export "$xdg"
  mkdir -p "${(P)xdg}"
done

HISTFILE=$XDG_DATA_HOME/zsh/zsh_history
HISTSIZE=255
SAVEHIST=65535
setopt alwaystoend autolist automenu autoparamslash completeinword pathdirs
setopt autoresume longlistjobs nobgnice nocheckjobs nohup notify
setopt combiningchars interactivecomments nobeep nomailwarning rcquotes
setopt banghist extendedhistory incappendhistory nohistbeep nosharehistory
setopt histexpiredupsfirst histfindnodups histignorealldups histignoredups
setopt histignorespace histreduceblanks histsavenodups histverify
setopt extendedglob promptsubst normstarsilent noflowcontrol nomenucomplete
bindkey -v

export LANG=en_US.UTF-8
export LESS='-g -i -M -R -S -w -z-4'

export BROWSER=com.brave.Browser
export TERMINAL=st
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

export MANPAGER="nvim +Man!"

cdpath=(
  $HOME/git/angelogambara
  $HOME/git/angelogambara/dotfiles
)

fpath=("$ZDOTDIR"/completions $fpath)

export GOPATH=$HOME/go/bin

prepath=(
  $HOME/bin/statusbar(N)
  $HOME/bin(N)
  $HOME/.bin/statusbar(N)
  $HOME/.bin(N)
  $HOME/.local/bin/statusbar(N)
  $HOME/.local/bin(N)
  $GOPATH(N)
  $XDG_DATA_HOME/cargo/bin(N)
  $XDG_DATA_HOME/nvim/mason/bin(N)
)

export GNUPGHOME=$HOME/.gnupg

if [[ -r "$GNUPGHOME"/gpg.sh ]]; then
  source "$GNUPGHOME"/gpg.sh
fi

zstyle ':zephyr:plugin:completion' compstyle zephyr

zstyle ':zephyr:plugin:editor' key-bindings vi
zstyle ':zephyr:plugin:editor' dot-expansion yes
zstyle ':zephyr:plugin:editor' magic-enter yes

zstyle ':zephyr:plugin:editor:magic-enter' command 'ls -a'
zstyle ':zephyr:plugin:editor:magic-enter' git-command 'git status --short'

zstyle ':zephyr:plugin:history' histfile "$HISTFILE"
zstyle ':zephyr:plugin:history' histsize "$HISTSIZE"
zstyle ':zephyr:plugin:history' savehist "$SAVEHIST"

source "$ZDOTDIR"/antidote.zsh

for rc in "$ZDOTDIR"/conf.d/*.zsh; do
  [[ ${rc:t} == '~'* ]] && continue
  source "$rc"
done
