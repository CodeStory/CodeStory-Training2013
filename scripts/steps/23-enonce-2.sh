#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/bonne-nuit" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/enonce-2" ]; then
	echo "POST enonce-2 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}enonce/2"
	RESPONSE=$(curl -o /dev/null -sL --data-binary @enonces/2.md -w "%{http_code}" $URL)

	if [[ $RESPONSE =~ ^201$ ]]; then
		echo $RESPONSE > logins/$LOGIN/enonce-2
	fi
	if [[ $RESPONSE =~ ^200$ ]]; then
		echo $RESPONSE > logins/$LOGIN/enonce-2
	fi
fi
