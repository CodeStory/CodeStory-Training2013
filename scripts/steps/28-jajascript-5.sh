#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/jajascript-4" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-5" ]; then
	echo "POST jajascript-5 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}jajascript/optimize"
	RESPONSE=$(curl --data-binary @enonces/jajascript/5.json -Ls $URL | tr -d '\n\r')
	VALID=$(echo "$RESPONSE" | coffee lags/lags-validator.coffee 5)

	if [[ $VALID =~ ^OK$ ]]; then
		echo $RESPONSE > logins/$LOGIN/jajascript-5
	fi
fi
