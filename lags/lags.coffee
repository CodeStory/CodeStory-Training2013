class TripOptimizer
	constructor : (lines) ->
		@trips = (new Trip(line) for line in lines.split '\n')

	optimize : (trips) ->
		return @optimize(@trips) unless trips?
		return 0 if trips.length == 0
		currentTrip = trips[0]
		nonOverlappingTrips = trips[1..].filter (trip) -> not currentTrip.overlap trip
		currentGain = currentTrip.gain + @optimize nonOverlappingTrips
		return Math.max currentGain, @optimize trips[1..]


class Trip
	constructor : (description) ->
		splittedDescription = description.split(' ')
		@name = splittedDescription[0]
		[@takeOffTime, @duration, @gain] = (+line for line in splittedDescription[1..])

	overlap : (trip) ->
		@takeOffTime + @duration > trip.takeOffTime && trip.takeOffTime + trip.duration > @takeOffTime

exports.Trip=Trip
exports.TripOptimizer=TripOptimizer