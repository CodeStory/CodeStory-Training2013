#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/ndeloof" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-8" ]; then
	echo "POST jajascript-8 for $LOGIN"
	
	cd lags
	JSON=$(coffee simple-generator.coffee 4)
	cd ..
	
	echo $JSON

	EXPECTED_GAIN=$(java -cp scripts/lags.jar Main $JSON)
	echo Expected: $EXPECTED_GAIN

	SERVER=$(cat logins/$LOGIN/server)
	T="$(date +%s)"
	URL="${SERVER}jajascript/optimize"
	T="$(($(date +%s)-T))"
	RESPONSE=$(curl --data-binary "$JSON" -Ls $URL)
	echo Response: $RESPONSE
	echo Time: $T
	
	GAIN=$(echo $RESPONSE | coffee lags/stripgain.coffee)
	echo Actual: $GAIN
	
	if [[ $EXPECTED_GAIN == $GAIN ]]; then
		echo $T > logins/$LOGIN/jajascript-8
	fi
fi
