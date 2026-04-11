function {
  0=${(%):-%x}
  local staticfile=${0:A}
  [[ -e ${staticfile} ]] || return 1
  if [[ ! -s ${staticfile}.zwc || ${staticfile} -nt ${staticfile}.zwc ]]; then
    builtin autoload -Uz zrecompile
    zrecompile -pq ${staticfile}
  fi
}
fpath+=( "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/completion" )
source "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/completion/completion.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/compstyle" )
source "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/compstyle/compstyle.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/editor" )
source "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/editor/editor.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/environment" )
source "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/environment/environment.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/history" )
source "$HOME/.cache/antidote/github.com/mattmc3/zephyr/plugins/history/history.plugin.zsh"
source "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/lib/clipboard.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/copybuffer" )
source "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/copybuffer/copybuffer.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/copyfile" )
source "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/copypath" )
source "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/copypath/copypath.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/git" )
source "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/git-commit" )
source "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/git-commit/git-commit.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/git-extras" )
source "$HOME/.cache/antidote/github.com/ohmyzsh/ohmyzsh/plugins/git-extras/git-extras.plugin.zsh"
