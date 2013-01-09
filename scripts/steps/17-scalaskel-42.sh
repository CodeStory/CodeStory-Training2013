#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/scalaskel-28" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/scalaskel-42" ]; then
	echo "GET scalaskel-42 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL=${SERVER}scalaskel/change/42
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')
	VALID=$(java -cp scripts/scalaskel.jar Scalaskel 42 "$RESPONSE")

	if [[ $VALID =~ ^OK$ ]]; then
		echo $RESPONSE > logins/$LOGIN/scalaskel-42
	fi
fi
