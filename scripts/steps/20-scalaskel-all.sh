#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/scalaskel-97" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/scalaskel-all" ]; then
	echo "GET scalaskel-all for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	
	for cents in {1..100}; do
		URL=${SERVER}scalaskel/change/$cents
		RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')
		VALID=$(java -cp scripts/scalaskel.jar Scalaskel "$cents" "$RESPONSE")

		if [[ ! $VALID =~ ^OK$ ]]; then
			exit 0
		fi
	done

	echo $RESPONSE > logins/$LOGIN/scalaskel-all
fi
