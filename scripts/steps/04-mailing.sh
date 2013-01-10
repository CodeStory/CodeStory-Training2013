#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/email" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/mailing" ]; then
	echo "GET mailing for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Es+tu+abonne+a+la+mailing+list(OUI/NON)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $RESPONSE =~ ^OUI$ ]]; then
		echo $RESPONSE > logins/$LOGIN/mailing
	fi
fi
