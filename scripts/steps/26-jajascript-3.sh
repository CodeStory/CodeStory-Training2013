#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/jajascript-2" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-3" ]; then
	echo "POST jajascript-3 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}jajascript/optimize"
	RESPONSE=$(curl --data-binary @enonces/jajascript/3.json -Ls $URL)
	VALID=$(echo "$RESPONSE" | coffee lags/lags-validator.coffee 3)

	if [[ $VALID =~ ^OK$ ]]; then
		echo $RESPONSE > logins/$LOGIN/jajascript-3
	fi
fi
