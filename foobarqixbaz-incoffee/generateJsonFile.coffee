Coins = require './coins.coffee'


coins = new Coins()
testRange = [0,1,2,7,8,11,19,21,42,97]
dataset = {}
for number in testRange
	dataset[number] = coins.change number

console.log JSON.stringify dataset
