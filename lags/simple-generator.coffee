gen = require './lags-gen.coffee'

iteration = process.argv[2] || 3

trips = []
gen.generator iteration, 0, trips
console.log JSON.stringify(trips, {}, ' ')