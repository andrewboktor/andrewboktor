#!/bin/bash
while true;
do
	ssh ssh-linux6.ece.ubc.ca -L 8888:aamodt-pc3:1666 -D 54321 -Y;
	echo "Connection failed, sleeping 5 seconds";
	sleep 5;
	echo "Retrying connection ...";
done;
