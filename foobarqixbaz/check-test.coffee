check = require './check.coffee'
should = require('chai').should()

describe 'check', ->

	it 'should find foo:1', ->
		check(1, [{foo:1}]).should.be.true

	it 'should not find foo:2', ->
		check(1, [{foo:2}]).should.be.false

	it 'should not find valid for 42', ->
		check(42, [{foo:42},{bar:6},{qix:3, bar:1, foo:2},{baz:2}]).should.be.true

	it 'should not find partial for 42', ->
		check(42, [{foo:42},{qix:3, bar:1, foo:2},{baz:2}]).should.be.false

	it 'should not find wrong for 42', ->
		check(42, [{foo:43},{qix:3, bar:1, foo:2},{baz:2}]).should.be.false