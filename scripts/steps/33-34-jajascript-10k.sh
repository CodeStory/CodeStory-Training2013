#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/ndeloof" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/jajascript-10k" ]; then
	echo "POST jajascript-10k for $LOGIN"
	
	MAX=0
	for COUNT in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 30 50 100 200 300 400 500 600 700 800 1000 2000 10000; do
		echo LEVEL: $COUNT
		cd lags
		JSON=$(coffee simple-generator.coffee $COUNT)
		cd ..
		
		EXPECTED_GAIN=$(echo $JSON | java -cp scripts/lags.jar Main)
		echo EXPECTED: $EXPECTED_GAIN
	
		SERVER=$(cat logins/$LOGIN/server)
		URL="${SERVER}jajascript/optimize"
	
		RESPONSE=$(echo $JSON | curl -m 30 --data-binary @- -s $URL)
		if [ "$?" -ne 0 ]; then
			break
		fi

		GAIN=$(echo $RESPONSE | coffee lags/stripgain.coffee 2>/dev/null)
		echo ACTUAL: $GAIN
		if [[ $EXPECTED_GAIN != $GAIN ]]; then
			MAX=0
			break
		fi

		MAX=$COUNT
	done
		
	if [ "$MAX" -gt 0 ]; then
		echo $MAX > logins/$LOGIN/jajascript-8
	fi
	if [[ $MAX == "10000" ]]; then
		echo $MAX > logins/$LOGIN/jajascript-10k
	fi
fi
