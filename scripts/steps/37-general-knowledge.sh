#!/bin/bash

LOGIN=$1
if [ -z $LOGIN ]; then
	echo "Please provide a login"
	exit 1
fi

if [ ! -e "logins/$LOGIN/pi" ]; then
	exit 0
fi

if [ ! -s "logins/$LOGIN/general-knowledge" ]; then
	echo "GET general-knowledge-question for $LOGIN"

	SERVER=$(cat logins/$LOGIN/server)
	INPUT=$(ruby ExtremeStartupXebia/input.rb GeneralKnowledgeQuestion)
	QUESTION=$(ruby ExtremeStartupXebia/question.rb GeneralKnowledgeQuestion $INPUT)
	URL=$SERVER?q=${QUESTION}
	RESPONSE=$(curl -Ls $URL | tr -d '\n\r')
	ruby ExtremeStartupXebia/response.rb GeneralKnowledgeQuestion $INPUT "$RESPONSE"
	VALID=$?

	if [[ VALID -eq 0 ]]; then
		echo $RESPONSE > logins/$LOGIN/general-knowledge
	else
		echo invalid
	fi
fi
