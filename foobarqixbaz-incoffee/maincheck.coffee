check = require './check.coffee'

argMoney = process.argv[2]
argPayload = process.argv[3]

if check(argMoney,argPayload)
	process.exit(0)
else
	process.exit(1)
