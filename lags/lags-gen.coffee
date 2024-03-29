lags = require './lags.coffee'
fs = require 'fs'

loadFile = (filename) ->
	lines = []
	fileData = fs.readFileSync filename, 'UTF-8'
	lines.push line for line in fileData.split('\n')
	return lines

class Words
	constructor: (filename) -> 
		@lines = []
		fileData = fs.readFileSync filename, 'UTF-8'
		@lines.push line for line in fileData.split('\n')

	random: ->
		@lines[random(@lines.length)]

class TripDescription
	constructor: (@VOL, @DEPART, @DUREE, @PRIX) ->

	toString: () ->
		"#{@VOL} #{@DEPART} #{@DUREE} #{@PRIX}"

adjectives = new Words 'adjective.txt'
nouns = new Words 'noun.txt'

random = (number) ->
	return Math.floor(Math.random() * number)

randomPrice = (number) ->
	random(number) + 1

randomDuration = (number) ->
	random(number)

randomName = ->
	"#{adjectives.random()}-#{nouns.random()}-#{randomPrice(99 )}"
	
do_generate = (seed, trips) ->
	trips.push new TripDescription randomName(), seed + randomDuration(5), 1 + randomDuration(10), randomPrice(30)
	trips.push new TripDescription randomName(), seed + randomDuration(5), 1 + randomDuration(10), randomPrice(20) + 3
	trips.push new TripDescription randomName(), seed + randomDuration(5), 1 + randomDuration(10), randomPrice(10)
	trips.push new TripDescription randomName(), seed + randomDuration(5), 1 + randomDuration(10), randomPrice(10) + 5
	trips.push new TripDescription randomName(), seed + randomDuration(5), 1 + randomDuration(20), randomPrice(7)

generator = (number, seed, trips) ->
	for n in [1..number]
		do_generate(seed, trips)
		seed = seed + 5

module.exports.generator = generator