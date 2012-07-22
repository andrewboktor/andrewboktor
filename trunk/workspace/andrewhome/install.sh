#!/bin/bash
ANDREWHOME_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FILES=".bashrc .vimrc .vim .screenrc .rtorrent.rc scripts"

RAND=$RANDOM

for f in $FILES
do
	if [ -e $HOME/$f ]; then
		echo "$HOME/$f already exists, moving it to $HOME/$f.$RAND.backup"
		mv $HOME/$f $HOME/$f.$RAND.backup
	fi
	ln -s $ANDREWHOME_ROOT/$f $HOME/$f
	echo -n "Adding "
	ls -l $HOME/$f
done
