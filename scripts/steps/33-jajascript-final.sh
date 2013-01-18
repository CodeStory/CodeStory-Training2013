#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/jajascript-8" ]; then
	exit 0
fi

if [ ! -e "logins/$LOGIN/beta" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-final" ]; then
	echo "POST jajascript-final for $LOGIN"

	cd lags
	JSON=$(coffee simple-generator.coffee 10000)
	cd ..

	EXPECTED_GAIN=$(echo $JSON | java -cp scripts/lags.jar Main)

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}jajascript/optimize"

	RESPONSE=$(echo $JSON | curl -m 30 --data-binary @- -Ls $URL)
	if [ "$?" -ne 0 ]; then
		break
	fi

	GAIN=$(echo $RESPONSE | coffee lags/stripgain.coffee 2>/dev/null)
	if [[ $EXPECTED_GAIN == $GAIN ]]; then
		echo "10000" > logins/$LOGIN/jajascript-final
	fi
fi
