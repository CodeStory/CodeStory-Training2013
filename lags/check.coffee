lags = require './lags.coffee'
gen = require './lags-gen.coffee'

theirAnswer = process.argv[2]

stdin = process.openStdin()
stdin.setEncoding 'utf8'

stdin.on 'data', (response) ->
	rawTrips = JSON.parse response
	trips = []
	for rawTrip in rawTrips
		trips.push "#{rawTrip.name} #{rawTrip.start} #{rawTrip.length} #{rawTrip.price}"
	ourAnswer = new lags.TripOptimizer(trips.join("\n")).optimize()
	if ourAnswer=theirAnswer
		console.log 'OK'
	else
		console.log 'KO'