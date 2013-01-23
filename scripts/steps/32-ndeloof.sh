#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/jajascript-7" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/ndeloof" ]; then
	echo "GET ndeloof for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=As+tu+copie+le+code+de+ndeloof(OUI/NON/JE_SUIS_NICOLAS)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $LOGIN =~ ^ndeloof$ ]]; then
		if [[ $RESPONSE =~ ^JE_SUIS_NICOLAS$ ]]; then
			echo $RESPONSE > logins/$LOGIN/ndeloof
		fi
	else
		if [[ $RESPONSE =~ ^NON$ ]]; then
			echo $RESPONSE > logins/$LOGIN/ndeloof
		fi
	fi
fi
