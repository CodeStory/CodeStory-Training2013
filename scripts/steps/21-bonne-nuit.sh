#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/calcul" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/bonne-nuit" ]; then
	echo "GET bonne-nuit for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="$SERVER?q=As+tu+passe+une+bonne+nuit+malgre+les+bugs+de+l+etape+precedente(PAS_TOP/BOF/QUELS_BUGS)"
	RESPONSE=$(curl -Ls "$URL" | tr -d '\n\r')

	if [[ $RESPONSE =~ ^PAS_TOP$ ]]; then
		echo $RESPONSE > logins/$LOGIN/bonne-nuit
	fi
	if [[ $RESPONSE =~ ^BOF$ ]]; then
		echo $RESPONSE > logins/$LOGIN/bonne-nuit
	fi
	if [[ $RESPONSE =~ ^QUELS_BUGS$ ]]; then
		echo $RESPONSE > logins/$LOGIN/bonne-nuit
	fi
fi
