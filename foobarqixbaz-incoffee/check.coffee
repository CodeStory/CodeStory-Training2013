Coins = require './Coins.coffee'
deepContains = require './deepcontains.coffee'

check = (money, payload) ->
	coins = new Coins()
	goodPayload = coins.change +money
	for set in payload
		unless deepContains goodPayload, set
			console.log "#{set} is not valid" 
			return false
	for set in goodPayload
		unless deepContains payload, set
			console.log "missing #{set}" 
			return false			
	return true

module.exports=check