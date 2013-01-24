#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/jajascript-10k" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/feet-to-meter" ]; then
	echo "GET feet-to-meter for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	INPUT=$(ruby ExtremeStartupXebia/input.rb FeetToMetersQuestion)
	QUESTION=$(ruby ExtremeStartupXebia/question.rb FeetToMetersQuestion $INPUT)
	URL=$SERVER?q=${QUESTION}
	RESPONSE=$(curl -Ls $URL | tr -d '\n\r')
	ruby ExtremeStartupXebia/response.rb FeetToMetersQuestion $INPUT "$RESPONSE"
	VALID=$?

	if [[ VALID -eq 0 ]]; then
		echo $RESPONSE > logins/$LOGIN/feet-to-meter
	fi
fi
