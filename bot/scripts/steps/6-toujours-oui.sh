#!/bin/bash

LOGIN=$1

if [ ! -e "logins/$LOGIN/post-ready" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/toujours-oui" ]; then
	echo "Retrieve toujours-oui for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Est+ce+que+tu+reponds+toujours+oui(OUI/NON)"
	TOUJOURS_OUI=$(curl -s "$URL" | tr -d '\n\r')

	if [[ $TOUJOURS_OUI =~ ^NON$ ]]; then
		echo $TOUJOURS_OUI > logins/$LOGIN/toujours-oui
	fi
fi
