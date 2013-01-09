deepContains = require './deepContains.coffee'
Coins = require './coins.coffee'
should = require('chai').should()
_ = require 'underscore'

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
