#!/bin/bash

LOGIN=$1

if [ ! -e "logins/$LOGIN/mailing" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/mood" ]; then
	echo "Retrieve mood for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Es+tu+heureux+de+participer(OUI/NON)"
	MOOD=$(curl -s "$URL" | tr -d '\n\r')

	if [[ $MOOD =~ ^OUI$ ]]; then
		echo $MOOD > logins/$LOGIN/mood
	fi
fi
