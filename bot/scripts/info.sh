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
MAILING=$(fichier 'mailing')
MOOD=$(fichier 'mood')
POST_READY=$(fichier 'post-ready')
TOUJOURS_OUI=$(fichier 'toujours-oui')
ENONCE_1=$(fichier 'enonce-1')
ACK_ENONCE_1=$(fichier 'ack-enonce-1')

echo -e "$LOGIN;[$EMAIL];[$TYPE];[$MAILING];[$MOOD];[$POST_READY];[$TOUJOURS_OUI];[$ENONCE_1];[$ACK_ENONCE_1]"
