#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

function fichier() {
	echo $(cat logins/$LOGIN/$1 2> /dev/null || echo ?)
}

SERVER=$(fichier 'server')
EMAIL=$(fichier 'email')
TYPE=$(fichier 'type')

MAX_STEP=0
STEPS=$(./scripts/steps.sh)

for STEP in $STEPS; do
	if [ -e logins/$LOGIN/${STEP#*-} ]; then
		MAX_STEP=$((MAX_STEP + 1))
	fi
done

echo -e "[$(printf "%02d" $MAX_STEP)];$LOGIN;[$EMAIL];[$SERVER];[$TYPE]"