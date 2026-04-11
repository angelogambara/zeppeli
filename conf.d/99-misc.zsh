#!/bin/zsh
# -------------------------------------------

export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=Adwaita-Dark
export QT_QPA_PLATFORMTHEME=gnome

gsettings set org.gnome.desktop.interface  gtk-theme 'Adwaita-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'

# -------------------------------------------

xterm_title_waiting() {
  print -Pn "\e]2;%n@%m: %~\a"
}

xterm_title_running() {
  print -Pn "\e]2;%n@%m: %~ %# ${(q)1}\a"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd  xterm_title_waiting
add-zsh-hook preexec xterm_title_running

# -------------------------------------------

autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# -------------------------------------------

bindkey -M emacs "${key_info[PageUp]}"   history-beginning-search-backward
bindkey -M viins "${key_info[PageUp]}"   history-beginning-search-backward
bindkey -M vicmd "${key_info[PageUp]}"   history-beginning-search-backward

bindkey -M emacs "${key_info[PageDown]}" history-beginning-search-forward
bindkey -M viins "${key_info[PageDown]}" history-beginning-search-forward
bindkey -M vicmd "${key_info[PageDown]}" history-beginning-search-forward

bindkey -M emacs "${key_info[BackTab]}" reverse-menu-complete
bindkey -M viins "${key_info[BackTab]}" reverse-menu-complete
bindkey -M vicmd "${key_info[BackTab]}" reverse-menu-complete

# -------------------------------------------

zstyle ':completion:*' special-dirs false

# -------------------------------------------

export FZF_DEFAULT_OPTS="--border=rounded --exact --border=bold --layout=reverse --margin=3%"

FZF_CACHE=$XDG_CACHE_HOME/zsh/cached-eval/fzf-zsh.zsh

math_expr=( ${FZF_CACHE}(Nmh-12) )
if [[ ! -s "${FZF_CACHE}" ]] || (( ! ${#math_expr} )); then
  mkdir -p "${FZF_CACHE:h}"
  fzf --zsh >| "$FZF_CACHE"
fi

source "$FZF_CACHE"

# -------------------------------------------

export STARSHIP_CONFIG=$ZDOTDIR/themes/hydro.toml

STARSHIP_CACHE=$XDG_CACHE_HOME/zsh/cached-eval/starship-init-zsh.zsh

math_expr=( ${STARSHIP_CACHE}(Nmh-12) )
if [[ ! -s "${STARSHIP_CACHE}" ]] || (( ! ${#math_expr} )); then
  mkdir -p "${STARSHIP_CACHE:h}"
  starship init zsh >| "$STARSHIP_CACHE"
fi

source "$STARSHIP_CACHE"

# -------------------------------------------

ZOXIDE_CACHE=$XDG_CACHE_HOME/zsh/cached-eval/zoxide-init-zsh.zsh

math_expr=( ${ZOXIDE_CACHE}(Nmh-12) )
if [[ ! -s "${ZOXIDE_CACHE}" ]] || (( ! ${#math_expr} )); then
  mkdir -p "${ZOXIDE_CACHE:h}"
  zoxide init zsh >| "$ZOXIDE_CACHE"
fi

source "$ZOXIDE_CACHE"

unset math_expr

# -------------------------------------------

# Scheme name: Gruvbox dark, soft
# Scheme system: base16
# Scheme author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
# Template author: Tinted Theming (https://github.com/tinted-theming)

_gen_fzf_default_opts() {

local color00='#32302f'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts
