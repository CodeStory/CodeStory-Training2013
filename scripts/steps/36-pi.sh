#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/feet-to-meter" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/pi" ]; then
	echo "GET pi for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	INPUT=$(ruby ExtremeStartupXebia/input.rb PiQuestion)
	QUESTION=$(ruby ExtremeStartupXebia/question.rb PiQuestion $INPUT)
	URL=$SERVER?q=${QUESTION}
	RESPONSE=$(curl -Ls $URL | tr -d '\n\r')
	ruby ExtremeStartupXebia/response.rb PiQuestion $INPUT "$RESPONSE"
	VALID=$?

	if [[ VALID -eq 0 ]]; then
		echo $RESPONSE > logins/$LOGIN/pi
	fi
fi
