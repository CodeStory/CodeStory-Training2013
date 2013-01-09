#!/bin/bash

LOGIN=$1
if [ ! -s "logins/$LOGIN/email" ]; then
	echo "Retrieve email for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	URL=$SERVER?q=Quelle+est+ton+adresse+email
	EMAIL=$(curl -s "$URL" | tr -d '\n\r')

	if [[ $EMAIL =~ ([^@]+)@(.*)\.([a-zA-Z]+) ]]; then
		echo $EMAIL > logins/$LOGIN/email
	fi
fi
