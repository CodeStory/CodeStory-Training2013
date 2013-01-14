# takes a question number as unique argument ; reads response from standard input and produces OK or KO

lags = require './lags.coffee'

questions = [
	'AF514 0 5 10',
	'AF1 0 1 10\nAF2 1 1 10',
	'AF1 0 1 5\nAF2 0 1 6',
	'AF1 0 1 2\nAF2 1 1 4\nAF3 2 1 6',
	'AF1 0 1 4\nAF2 0 1 2\nAF3 2 1 6',
	'AF514 0 5 10\nCO5 3 7 14\nAF515 5 9 7\nBA01 6 9 8',
	'MONAD42 0 5 10\nMETA18 3 7 14\nLEGACY01 5 9 8\nYAGNI17 5 9 7'
]

bestGain = new lags.TripOptimizer(questions[process.argv[2] - 1]).optimize()

stdin = process.openStdin()
stdin.setEncoding 'utf8'

stdin.on 'data', (response) ->
	parsedResponse = JSON.parse response
	if bestGain == parsedResponse.gain
		console.log 'OK'
	else
		console.log 'KO'
