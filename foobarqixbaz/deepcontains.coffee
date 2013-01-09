_ = require 'underscore'

deepContains = (list,target) -> 
	_.some list , (value) -> _.isEqual value, target

module.exports = deepContains