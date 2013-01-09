#!/bin/bash

COMMAND=$1
if [ -z $COMMAND ]; then
	echo "Please provide a command"
	exit 0
fi

SCRIPT=./scripts/$COMMAND.sh
if [ ! -e $SCRIPT ]; then
	echo "Script $SCRIPT does not exist"
	exit 0
fi

ruby -e 'Dir["logins/*"].each{|x| puts File.basename(x)}' | parallel $SCRIPT {}
