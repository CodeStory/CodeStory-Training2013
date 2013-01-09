#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -s "logins/$LOGIN/type" ]; then
	echo "GET type for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL=$SERVER?q=Quelle+est+ton+adresse+email
	TYPE=$(curl -sLI $SERVER | awk '/Server:/ { print $2 }' | tr -d '\n\r')

	echo $TYPE > logins/$LOGIN/type
fi
