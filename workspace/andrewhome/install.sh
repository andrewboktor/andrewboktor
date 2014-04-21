#!/bin/bash
ANDREWHOME_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FILES=".bashrc .bash_profile .vimrc .vim .screenrc .rtorrent.rc scripts .ssh/config"

RAND=$RANDOM

for f in $FILES
do
    if [ -e $HOME/$f ]; then
        f1=`realpath $HOME/$f`
        f2=`realpath $ANDREWHOME_ROOT/$f`
        if [ $f1 == $f2 ]; then
            echo "$HOME/$f -> $ANDREWHOME_ROOT/$f is correctly linked. Not touching it."
        else
            echo "$HOME/$f already exists, moving it to $HOME/$f.$RAND.backup"
            mv $HOME/$f $HOME/$f.$RAND.backup
        fi
    else
        ln -s $ANDREWHOME_ROOT/$f $HOME/$f
        echo -n "Adding "
        ls -l $HOME/$f
    fi
done
