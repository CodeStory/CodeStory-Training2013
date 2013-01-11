fs = require 'fs'
crypto = require 'crypto'

class Player
	constructor: (@name, @level) ->

readLine = (file) ->
	return null unless fs.existsSync file
	value = fs.readFileSync file, 'UTF-8'
	index = value.indexOf '\n'
	return null if index == 0
	return value[0..index-1]

players = []
fs.readdir './logins', (err,files) ->
	for file in files
		if (file != '.DS_Store')
			level = fs.readdirSync("./logins/#{file}").length
			email = readLine "./logins/#{file}/email"
			emailHash = crypto.createHash('md5').update(email).digest("hex") if email?
			type = readLine "./logins/#{file}/type"
			player = new Player file, level
			player.gravatar = "http://www.gravatar.com/avatar/#{emailHash}" if emailHash?
			player.type = type if type?
			players.push player
			console.log JSON.stringify players