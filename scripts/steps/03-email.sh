#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/type" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/email" ]; then
	echo "GET email for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL=$SERVER?q=Quelle+est+ton+adresse+email
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')
	
	if [[ $RESPONSE =~ ^([^@]+)@(.*)\.([a-zA-Z]+)$ ]]; then
		echo $RESPONSE > logins/$LOGIN/email
	fi
fi
