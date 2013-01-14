stdin = process.openStdin()
stdin.setEncoding 'utf8'

stdin.on 'data', (json) ->
	response = JSON.parse json
	console.log response.gain