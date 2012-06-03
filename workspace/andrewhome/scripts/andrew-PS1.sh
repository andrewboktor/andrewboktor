#!/bin/bash
# Andrew Boktor PS1 file

PS1-smile () {
	if [ $? == 0 ];
	then
		echo -e "\e[1;32m:)\e[0m";
	else
		echo -e "\e[1;31m:(\e[0m";
	fi
}


if [ $USER = 'root' ]; then
	PS1='`PS1-smile` \[\e[1;31m\]\u\[\e[0;32m\]@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] '
else
	PS1='`PS1-smile` \[\e[1;33m\]\u\[\e[0;32m\]@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;33m\]\$\[\e[m\] '
fi

