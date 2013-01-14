#!/bin/bash

echo "["
for login in $(./scripts/logins.sh); do
	level=23
	time="2013-01-13T19:58:39.000Z"
	
	time=$(perl -mPOSIX -e 'print POSIX::strftime("%Y-%m-%dT%H:%M:%S.000Z\n", localtime((stat("./logins/$login"))[9]))')
	level=$(ls -1 ./logins/$login | wc -l)

	if [ -e ./logins/$login/email ]; then
		email=`cat ./logins/$login/email`
		hash=`echo -n $email | md5sum | sed  's/[\w -]*//g'`
		gravatar="http://www.gravatar.com/avatar/$hash/?s=64"
		
		echo "{\"name\":\"$login\",\"level\":$level,\"time\":\"$time\",\"gravatar\":\"$gravatar\"},"
	else
		echo "{\"name\":\"$login\",\"level\":$level,\"time\":\"$time\"},"
	fi
	
done
echo "{}]"
