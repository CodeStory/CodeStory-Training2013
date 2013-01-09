#!/bin/bash

LOGIN=$1
if [ ! -s "logins/$LOGIN/type" ]; then
	echo "Retrieve server type for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL=$SERVER?q=Quelle+est+ton+adresse+email
	TYPE=$(curl -sI $SERVER | awk '/Server:/ { print $2 }' | tr -d '\n\r')

	echo $TYPE > logins/$LOGIN/type
fi
