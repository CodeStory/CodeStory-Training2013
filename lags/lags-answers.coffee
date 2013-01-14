lags = require './lags.coffee'
gen = require './lags-gen.coffee'

trips = []

if process.argv[2]?
	iteration = process.argv[2]
else
	iteration = 3

console.log "Generation of #{iteration * 5} Trips"
gen.generator iteration, 0, trips

# Pretty print pour enoncé
#console.log trip.toString() for trip in trips

#Pretty print pour David
console.log "   QUESTION   "
console.log JSON.stringify trips

console.log "   ANSWER   "
console.time("compute")
console.log new lags.TripOptimizer(trips.join("\n")).optimize()
console.timeEnd("compute")