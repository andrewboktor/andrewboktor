#!/bin/bash
# Andrew Boktor bashrc file

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#This script contains a bunch of environment variables likes EDITOR ...
source $DIR/scripts/andrew-env.sh

# Source colors first thing (other scripts use it)
source $DIR/scripts/andrew-colors.sh

source $DIR/scripts/archlinux-splash.sh

source $DIR/scripts/andrew-PS1.sh

#test -s ~/.alias && . ~/.alias || true


source $DIR/scripts/andrew-alias.sh

#export TERM='xterm-256color'
#source $HOME/bin/source.sh


#PERFORCE P4
#export P4CONFIG='.p4config'
#export P4EDITOR='vim'
