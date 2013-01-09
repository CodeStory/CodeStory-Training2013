deepContains = require './deepContains.coffee'
should = require('chai').should()
_ = require 'underscore'

describe 'deepContains', ->

	it 'should find an element', ->
		deepContains([{foo:1}, {bar:1}], bar:1).should.be.true

	it 'should not find an element', ->
		deepContains([{foo:1}, {bar:1}], bar:3).should.be.false

	it 'should find a complex element', ->
		deepContains([{foo:1}, {bar:1,foo:2}], {bar:1,foo:2}).should.be.true
