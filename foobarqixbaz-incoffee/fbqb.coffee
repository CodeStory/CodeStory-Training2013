should = require('chai').should()
_ = require 'underscore'

describe 'deepContains', ->

	it 'should find an element', ->
		deepContains([{foo:1}, {bar:1}], bar:1).should.be.true

	it 'should not find an element', ->
		deepContains([{foo:1}, {bar:1}], bar:3).should.be.false

	it 'should find a complex element', ->
		deepContains([{foo:1}, {bar:1,foo:2}], {bar:1,foo:2}).should.be.true


deepContains = (list,target) ->
	_.some list , (value) -> _.isEqual value, target


describe 'FooBarQixBaz', ->
	it 'should return [] for 0', ->
		coins = new Coins()
		coins.change(0).should.eql []

	it 'should return foo:1 for 1', ->
		coins = new Coins()
		coins.change(1)[0].should.eql foo:1

	it 'should return foo:2 for 2', ->
		coins = new Coins()
		coins.change(2)[0].should.eql foo:2

	it 'should return foo:7,bar:1 for 7', ->
		coins = new Coins()
		set = coins.change 7
		deepContains(set, foo:7).should.be.true

	it 'should return foo:8,bar:1,foo:1 for 8', ->
		coins = new Coins()
		set = coins.change 8
		deepContains(set, foo:8).should.be.true
		deepContains(set, {bar:1,foo:1}).should.be.true

	it 'should return qix:1 for 11', ->
		coins = new Coins()
		set = coins.change 11
		deepContains(set, foo:11).should.be.true
		deepContains(set, {bar:1,foo:4}).should.be.true
		deepContains(set, qix:1).should.be.true

	it 'should return qix:1,bar:1,foo:1 for 19', ->
		coins = new Coins()
		set = coins.change 19
		deepContains(set, foo:19).should.be.true
		deepContains(set, {bar:2,foo:5}).should.be.true
		deepContains(set, {qix:1,bar:1,foo:1}).should.be.true

	it 'should return baz:1,bar:1,foo:1 for 21', ->
		coins = new Coins()
		set = coins.change 21
		deepContains(set, foo:21).should.be.true
		deepContains(set, {bar:3}).should.be.true
		deepContains(set, {qix:1, bar:1, foo:3}).should.be.true
		deepContains(set, baz:1).should.be.true

	it 'should return baz:1,bar:1,foo:1 for 42', ->
		coins = new Coins()
		set = coins.change 42
		deepContains(set, foo:42).should.be.true
		deepContains(set, bar:6).should.be.true
		deepContains(set, {qix:3, bar:1, foo:2}).should.be.true
		deepContains(set, baz:2).should.be.true

class Coins 
	constructor : ->
		@coins = baz:21, qix:11, bar:7, foo:1

	getValueOf : (key) -> # poor's man hashmap
		return value for name,value of @coins when name == key

	getCoinsNames : ->
		name for name,value of @coins

	handleCoin : (money,result,coin) ->
		coinValue = @getValueOf(coin)
		if money >= coinValue
			result[coin] = Math.floor(money / coinValue)
			return money - result[coin] * coinValue

	change : (money) -> 
		resultArray = []	
		for i in [0..3]
			rest = money
			result = {}
			for coin in @getCoinsNames()[i..]
				rest = @handleCoin(rest,result,coin)
			resultArray.push result unless _.isEmpty(result)
		return resultArray

#generate dataset files for tests
coins = new Coins()
testRange = [0,1,2,7,8,11,19,21,42,97]
dataset = {}
for number in testRange
	dataset[number] = coins.change number

console.log JSON.stringify dataset