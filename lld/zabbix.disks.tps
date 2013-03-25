#!/bin/bash
STATS=$(/usr/bin/iostat -d 1 1 $1 | grep -v Device  | grep -v Linux  | awk '{print $2}' | sed 's/,/./g') 

if [ -z $STATS ] ; then 
	echo "NOT SUPPORTED" 
else
	echo $STATS
fi
