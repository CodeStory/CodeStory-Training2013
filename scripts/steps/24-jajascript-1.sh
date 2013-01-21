#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/ack-enonce-2" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-1" ]; then
	echo "POST jajascript-1 for $LOGIN"
	
	JSON=$(cat enonces/jajascript/1.json)
	
	EXPECTED_GAIN=$(echo $JSON | java -cp scripts/lags.jar Main)

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}jajascript/optimize"

	RESPONSE=$(echo $JSON | curl --data-binary @- -s $URL)

	GAIN=$(echo $RESPONSE | coffee lags/stripgain.coffee 2>/dev/null)
	if [[ $EXPECTED_GAIN == $GAIN ]]; then
		echo $RESPONSE > logins/$LOGIN/jajascript-1
	fi
fi
