#!/bin/zsh

# Conditional make workflow
alias mk='make && sudo make install && make clean'

# Print CSV to describe explicitly installed packages
alias pacinfo='pacman -Qqnett | xargs expac -Q "%n: %d\n"'

# List aliases
alias ls='eza --icons -a'
alias ll='eza --icons --git -la'

# Safety aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Color aliases
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Grep aliases
alias f='find . | grep'
alias h='history | grep'
alias p='ps aux | grep'
