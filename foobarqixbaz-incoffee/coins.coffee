_ = require 'underscore'

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

module.exports = Coins