#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/enonce-2" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/ack-enonce-2" ]; then
	echo "GET ack-enonce-2 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=As+tu+bien+recu+le+second+enonce(OUI/NON)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $RESPONSE =~ ^OUI$ ]]; then
		echo $RESPONSE > logins/$LOGIN/ack-enonce-2
	fi
	if [[ $RESPONSE =~ ^NON$ ]]; then
		rm logins/$LOGIN/enonce-2
	fi
fi
