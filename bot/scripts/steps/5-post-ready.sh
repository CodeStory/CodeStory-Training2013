#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/mood" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/post-ready" ]; then
	echo "GET post-ready for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Es+tu+pret+a+recevoir+une+enonce+au+format+markdown+par+http+post(OUI/NON)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $RESPONSE =~ ^OUI$ ]]; then
		echo $RESPONSE > logins/$LOGIN/post-ready
	fi
fi
