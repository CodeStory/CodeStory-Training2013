gen = require './lags-gen.coffee'



if process.argv[2]?
	iteration = process.argv[2]
else
	iteration = 3

iteration = 8 if iteration > 8

trips = []
gen.generator iteration, 0, trips
console.log JSON.stringify trips