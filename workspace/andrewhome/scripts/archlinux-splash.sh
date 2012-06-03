#!/bin/bash

#uncomment the following line to enable clearing the screen before printing the splash
#echo -e "\e[H\e[2J"
echo -e "        \e[1;36m, \e[1;37m                       _     \e[1;36m_ _                      \e[1;30m| \e[34m`uname -r -s`"
echo -e "       \e[1;36m/#\ \e[1;37m        __ _ _ __ ___| |__ \e[1;36m| (_)_ __  _   ___  __    \e[30m| `uname -p`"
echo -e "      \e[1;36m/###\ \e[1;37m      / _\` | '__/ __| '_ \\\\\e[1;36m| | | '_ \| | | \ \/ /    \e[30m|"
echo -e "     \e[1;36m/#####\ \e[1;37m    | (_| | | | (__| | | \e[1;36m| | | | | | |_| |>  <     \e[30m| \e[32m`date +%T`"
echo -e "    \e[1;36m/##\e[0;36m,-,##\ \e[1;37m    \__,_|_|  \___|_| |_\e[1;36m|_|_|_| |_|\__,_/_/\_\    \e[1;30m| \e[32m`date +%A\ %d\ %B\ %Y`"
echo -e "   \e[0;36m/##(   )##\                                                  \e[1;30m|"
echo -e "  \e[0;36m/#.--   --.#\ \e[1;37m      A simple, lightweight distribution.       \e[1;30m| \e[31m`users|wc -w` users"
echo -e " \e[0;36m/\`           \`\ \e[0m                                               \e[1;30m| \e[35m`echo $TERM` \e[0mon \e[1;33m`hostname` \e[0m"
