fs = require 'fs'

json = fs.readFileSync 'data.json.1','UTF-8'
data = JSON.parse json
data.sort (a,b) ->
	b.perf - a.perf
for user in data when user.level >= 33
	console.log "* ![](#{user.gravatar})#{user.name} #{user.perf}"