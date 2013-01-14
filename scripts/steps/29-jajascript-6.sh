#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/jajascript-5" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-6" ]; then
	echo "POST jajascript-6 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}jajascript/optimize"
	RESPONSE=$(curl --data-binary @enonces/jajascript/6.json -Ls $URL | tr -d '\n\r')
	VALID=$(echo "$RESPONSE" | coffee lags/lags-validator.coffee 6)

	if [[ $VALID =~ ^OK$ ]]; then
		echo $RESPONSE > logins/$LOGIN/jajascript-6
	fi
fi
