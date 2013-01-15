#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/ndeloof" ]; then
	exit 0
fi

if [ ! -e "logins/$LOGIN/beta" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-8" ]; then
	echo "POST jajascript-8 for $LOGIN"
	
	cd lags
	JSON=$(coffee simple-generator.coffee 8)
	cd ..
	
	echo $JSON

	EXPECTED_GAIN=$(java -cp scripts/lags.jar Main $JSON)
	echo expected: $EXPECTED_GAIN

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}jajascript/optimize"
	RESPONSE=$(curl --data-binary "$JSON" -Ls $URL)
	echo $RESPONSE
	
	GAIN=$(echo $RESPONSE | coffee lags/stripgain.coffee)
	echo $GAIN
	
	if [[ $EXPECTED_GAIN == $GAIN ]]; then
		echo $RESPONSE > logins/$LOGIN/jajascript-8
	fi
fi
