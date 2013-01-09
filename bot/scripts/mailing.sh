#!/bin/bash

LOGIN=$1

if [ ! -e "logins/$LOGIN/email" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/mailing" ]; then
	echo "Retrieve mailing list state for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Es+tu+abonne+a+la+mailing+list(OUI/NON)"
	EMAIL=$(curl -s "$URL" | tr -d '\n\r')

	if [[ $EMAIL =~ ^OUI$ ]]; then
		echo $EMAIL > logins/$LOGIN/mailing
	fi
fi
