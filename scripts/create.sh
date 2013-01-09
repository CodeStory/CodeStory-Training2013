#!/bin/bash

function erreur() {
	echo $1
	exit 1
}

LOGIN=$1
if [ -z $LOGIN ]; then
	erreur "Merci d'indiquer le login du participant"
fi

if [ -e "logins/$LOGIN" ]; then
	erreur "Le participant existe déjà"
fi

SERVER=$2
if [ -z $SERVER ]; then
	erreur "Merci d'indiquer l'adresse du serveur"
fi

echo "Création du participant $LOGIN..."
mkdir logins/$LOGIN
echo $SERVER > logins/$LOGIN/server
echo "Done"
