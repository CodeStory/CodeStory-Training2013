fs = require 'fs'
crypto = require 'crypto'

class Player
	constructor: (@name, @level, @time) ->

readLine = (file) ->
	return null unless fs.existsSync file
	value = fs.readFileSync file, 'UTF-8'
	index = value.indexOf '\n'
	return null if index == 0
	return value[0..index-1]

players = []

files = fs.readdirSync './logins'
for file in files when file != '.DS_Store'
	time = fs.statSync("./logins/#{file}")
	level = fs.readdirSync("./logins/#{file}").length
	email = readLine "./logins/#{file}/email"
	emailHash = crypto.createHash('md5').update(email).digest("hex") if email?
	type = readLine "./logins/#{file}/type"
	player = new Player file, level, time.mtime
	player.gravatar = "http://www.gravatar.com/avatar/#{emailHash}/?s=64" if email?
	player.type = type if type?
	players.push player

console.log JSON.stringify players