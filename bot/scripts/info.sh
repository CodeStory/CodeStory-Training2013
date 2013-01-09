#!/bin/bash

LOGIN=$1

function fichier() {
	echo $(cat logins/$LOGIN/$1 2> /dev/null || echo UNKNOWN)
}

SERVER=$(fichier 'server')
EMAIL=$(fichier 'email')
TYPE=$(fichier 'type')
MAILING=$(fichier 'mailing')
MOOD=$(fichier 'mood')
POST_READY=$(fichier 'post-ready')

echo -e "$LOGIN;[$SERVER];[$EMAIL];[$TYPE];[$MAILING];[$MOOD];[$POST_READY]"
