#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/toujours-oui" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/enonce-1" ]; then
	echo "POST enonce-1 for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL="${SERVER}enonce/1"
	RESPONSE=$(curl -sL --data-binary @enonces/1.md -w "%{http_code}" $URL)

	if [[ $RESPONSE =~ ^201$ ]]; then
		echo $RESPONSE > logins/$LOGIN/enonce-1
	fi
	if [[ $RESPONSE =~ ^200$ ]]; then
		echo $RESPONSE > logins/$LOGIN/enonce-1
	fi
fi
