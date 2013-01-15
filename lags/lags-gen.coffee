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

randomName = ->
	"#{adjectives.random()}-#{nouns.random()}-#{randomPrice(99 )}"

generator = (number,seed, trips) ->
	trips.push new TripDescription randomName(), seed + 0, 4, randomPrice(10) + 5
	trips.push new TripDescription randomName(), seed + 1, 2, randomPrice(10)
	trips.push new TripDescription randomName(), seed + 2, 6, randomPrice(7)
	trips.push new TripDescription randomName(), seed + 4, 5, randomPrice(20) + 3
	trips.push new TripDescription randomName(), seed + 5, 2, randomPrice(30)
	number -= 1
	seed = seed + 5
	generator number, seed, trips if number > 0

module.exports.generator = generator