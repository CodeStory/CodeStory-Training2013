#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/post-ready" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/toujours-oui" ]; then
	echo "GET toujours-oui for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Est+ce+que+tu+reponds+toujours+oui(OUI/NON)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $RESPONSE =~ ^NON$ ]]; then
		echo $RESPONSE > logins/$LOGIN/toujours-oui
	fi
fi
