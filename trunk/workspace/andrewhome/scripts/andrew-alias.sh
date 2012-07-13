#!/bin/bash
# Andrew Boktor alias file

export GREP_COLOR='1;33'
alias grep='grep --color=auto'
alias cgrep='grep --color=always'

alias less='less -R'

alias vi='vim'
alias vim='vim -p'
alias gvim='gvim -p'

eval `dircolors -b`
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias llh='ls -lh'
alias llah='ls -lah'

# Print the stack with one directory per line
alias dirs='dirs -p'
