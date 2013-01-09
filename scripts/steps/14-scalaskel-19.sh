#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/scalaskel-11" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/scalaskel-19" ]; then
	echo "GET scalaskel-19 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL=${SERVER}scalaskel/change/19
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')
	VALID=$(java -cp scripts/scalaskel.jar Scalaskel 19 "$RESPONSE")

	if [[ $VALID =~ ^OK$ ]]; then
		echo $RESPONSE > logins/$LOGIN/scalaskel-19
	fi
fi
