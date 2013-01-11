#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

#if [ ! -e "logins/$LOGIN/scalaskel-all" ]; then
#	exit 0
#fi

if [ ! -s "logins/$LOGIN/calcul" ]; then
	echo "GET calcul for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	
	for calcul in $(cat enonces/3.txt); do
		QUESTION=${calcul%;*}
		EXPECTED=${calcul#*;}
		
		URL="${SERVER}?q=$QUESTION"
		RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')
		
		if [ "$RESPONSE" != "$EXPECTED" ]; then
			exit 0
		fi
	done

	echo $RESPONSE > logins/$LOGIN/calcul
fi
