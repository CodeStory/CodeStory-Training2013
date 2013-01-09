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
SCALASKEL_1=$(fichier '9-scalaskel-1')
SCALASKEL_2=$(fichier '10-scalaskel-2')
SCALASKEL_7=$(fichier '11-scalaskel-7')
SCALASKEL_8=$(fichier '12-scalaskel-8')
SCALASKEL_11=$(fichier '13-scalaskel-11')
SCALASKEL_19=$(fichier '14-scalaskel-19')
SCALASKEL_21=$(fichier '15-scalaskel-21')
SCALASKEL_28=$(fichier '16-scalaskel-28')
SCALASKEL_42=$(fichier '17-scalaskel-42')
SCALASKEL_97=$(fichier '18-scalaskel-97')

echo -e "$LOGIN;[$EMAIL];[$TYPE];[$MAILING];[$MOOD];[$POST_READY];[$TOUJOURS_OUI];[$ENONCE_1];[$ACK_ENONCE_1];[$SCALASKEL_1];[$SCALASKEL_2];[$SCALASKEL_7];[$SCALASKEL_8];[$SCALASKEL_11];[$SCALASKEL_19];[$SCALASKEL_21];[$SCALASKEL_28];[$SCALASKEL_42];[$SCALASKEL_97]"