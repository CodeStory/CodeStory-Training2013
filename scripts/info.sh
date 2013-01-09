#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

function fichier() {
	echo $(cat logins/$LOGIN/$1 2> /dev/null || echo ?)
}

function existe() {
	if [ -e logins/$LOGIN/$1 ]; then
		echo OK
	else
		echo ?
	fi
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
SCALASKEL_1=$(existe 'scalaskel-1')
SCALASKEL_2=$(existe 'scalaskel-2')
SCALASKEL_7=$(existe 'scalaskel-7')
SCALASKEL_8=$(existe 'scalaskel-8')
SCALASKEL_11=$(existe 'scalaskel-11')
SCALASKEL_19=$(existe 'scalaskel-19')
SCALASKEL_21=$(existe 'scalaskel-21')
SCALASKEL_28=$(existe 'scalaskel-28')
SCALASKEL_42=$(existe 'scalaskel-42')
SCALASKEL_97=$(existe 'scalaskel-97')

echo -e "$LOGIN;[$EMAIL];[$MAILING];[$MOOD];[$POST_READY];[$TOUJOURS_OUI];[$ENONCE_1];[$ACK_ENONCE_1];[$SCALASKEL_1];[$SCALASKEL_2];[$SCALASKEL_7];[$SCALASKEL_8];[$SCALASKEL_11];[$SCALASKEL_19];[$SCALASKEL_21];[$SCALASKEL_28];[$SCALASKEL_42];[$SCALASKEL_97]"