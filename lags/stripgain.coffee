stdin = process.openStdin()
stdin.setEncoding 'utf8'

json = ''

stdin.on 'data', (part) ->
	json += part
	
stdin.on 'end', () -> 
	response = JSON.parse json
	console.log response.gain
