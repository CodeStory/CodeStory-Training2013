#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/jajascript-10k" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/participation" ]; then
	echo "GET participation for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=Souhaites-tu-participer-a-la-suite-de-Code-Story(OUI/NON)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $RESPONSE =~ ^OUI$ ]]; then
		echo $RESPONSE > logins/$LOGIN/participation
	fi
	if [[ $RESPONSE =~ ^NON$ ]]; then
		echo $RESPONSE > logins/$LOGIN/participation
	fi
fi

