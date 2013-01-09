#!/bin/bash

LOGIN=$1

if [ ! -e "logins/$LOGIN/mood" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/post-ready" ]; then
	echo "Retrieve post-ready for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Es+tu+pret+a+recevoir+une+enonce+au+format+markdown+par+http+post(OUI/NON)"
	POST_READY=$(curl -s "$URL" | tr -d '\n\r')

	if [[ $POST_READY =~ ^OUI$ ]]; then
		echo $POST_READY > logins/$LOGIN/post-ready
	fi
fi
