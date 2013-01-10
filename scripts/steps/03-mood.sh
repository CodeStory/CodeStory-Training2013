#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/mailing" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/mood" ]; then
	echo "GET mood for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Es+tu+heureux+de+participer(OUI/NON)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $RESPONSE =~ ^OUI$ ]]; then
		echo $RESPONSE > logins/$LOGIN/mood
	fi
fi
