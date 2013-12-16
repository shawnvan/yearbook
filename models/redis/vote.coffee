redisConnection = require '../../redisConnection'
class Vote
	constructor:()->
		@redisClient = redisConnection.getConnections().get()['vote']
		@__setKeys

	__setKeys:(tuid)->
		today = new Date
		year = do today.getFullYear
		month = (do today.getMonth)+1
		day = do today.getDate
		@key = "vote:#{year}#{month}#{day}:hash"


	#get voted times today 
	getVoteTimes:(tuid,cb)->
		@redisClient.hget @key,tuid,(err,reply)->
			return cb 0 if err?
			cb reply

	addVoteTimes:(tuid,cb)->
		args = [
			@key
			tuid
			1
		]
		@redisClient.hincrby args,(err,reply)->
			cb null if err?
			cb reply
module.exports = Vote