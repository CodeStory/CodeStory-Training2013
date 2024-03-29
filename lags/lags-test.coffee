lags = require './lags.coffee'

should = require('chai').should()

describe 'lags', ->

	it 'should read the name of the trip', ->
		new lags.Trip('AF514 0 5 10').name.should.equal 'AF514'

	it 'should read the starting time of the trip', ->
		new lags.Trip('AF514 0 5 10').takeOffTime.should.equal 0

	it 'should read the starting time of the trip', ->
		new lags.Trip('AF514 0 5 10').duration.should.equal 5

	it 'should read the gain of the trip', ->
		new lags.Trip('AF514 0 5 10').gain.should.equal 10

	it 'should return false, when two trip don\'t overlap ', ->
		trip1 = new lags.Trip('AF1 0 2 10')
		trip2 = new lags.Trip('AF2 10 2 11')
		trip1.overlap(trip2).should.be.false

	it 'should return true, when two trip overlap ', ->
		trip1 = new lags.Trip('AF1 0 2 10')
		trip2 = new lags.Trip('AF2 1 1 11')
		trip1.overlap(trip2).should.be.true

	it 'should return true, when two trip overlap but the second takeoff before the first', ->
		trip1 = new lags.Trip('AF1 0 2 10')
		trip2 = new lags.Trip('AF2 10 2 11')
		trip2.overlap(trip1).should.be.false

	it 'should return true, when two trip overlap but the second takeoff before the first', ->
		trip1 = new lags.Trip('AF1 0 2 10')
		trip2 = new lags.Trip('AF2 1 1 11')
		trip2.overlap(trip1).should.be.true

	it 'should read all trips', ->
		trips = new lags.TripOptimizer("""
			AF514 0 5 10
			CO5 3 7 14
 			""").trips
		trips.length.should.equal 2

	it 'should read fully the first lags.Trip out of a description', ->
		trips = new lags.TripOptimizer("""
			AF514 0 5 10
			CO5 3 7 14
 			""").trips
		trips[0].name.should.equal 'AF514'
		trips[0].takeOffTime.should.equal 0
		trips[0].duration.should.equal 5
		trips[0].gain.should.equal 10

	it 'should read fully the second lags.Trip out of a description', ->
		trips = new lags.TripOptimizer("""
			AF514 0 5 10
			CO5 3 7 14
 			""").trips
		trips[1].name.should.equal 'CO5'
		trips[1].takeOffTime.should.equal 3
		trips[1].duration.should.equal 7
		trips[1].gain.should.equal 14

	it 'should find the gain when there is only one plane', ->
		new lags.TripOptimizer("""
			AF514 0 5 10
 			""").optimize().should.equal 10

	it 'should find the gain when there is two planes with non-overlapping time', ->
		new lags.TripOptimizer("""
			AF1 0 1 10
			AF2 1 1 10
 			""").optimize().should.equal 20

	it 'should find the gain when there is two planes with overlapping time', ->
		new lags.TripOptimizer("""
			AF1 0 1 5
			AF2 0 1 6
 			""").optimize().should.equal 6

	it 'should find the gain when there is thre planes none overlapping', ->
		new lags.TripOptimizer("""
			AF1 0 1 2
			AF2 1 1 4
			AF3 2 1 6
 			""").optimize().should.equal 12

	it 'should find the gain when there is a choice to be made between two planes', ->
		new lags.TripOptimizer("""
			AF1 0 1 4
			AF2 0 1 2
			AF3 2 1 6
 			""").optimize().should.equal 10

	it 'should yell to the earth : Big Gain, Big Gain !', ->
		new lags.TripOptimizer("""
			AF514 0 5 10
			CO5 3 7 14
			AF515 5 9 7
			BA01 6 9 8
 			""").optimize().should.equal 18