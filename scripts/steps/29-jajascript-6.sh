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
	
	JSON=$(cat enonces/jajascript/6.json)
	
	EXPECTED_GAIN=$(echo $JSON | java -cp scripts/lags.jar Main)

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}jajascript/optimize"

	RESPONSE=$(echo $JSON | curl --data-binary @- -s $URL)

	GAIN=$(echo $RESPONSE | coffee lags/stripgain.coffee 2>/dev/null)
	if [ $EXPECTED_GAIN -eq $GAIN ]; then
		echo $RESPONSE > logins/$LOGIN/jajascript-6
	fi
fi
