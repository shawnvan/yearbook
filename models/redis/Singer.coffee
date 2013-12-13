redisConnection = require '../../redisConnection'
class Singer
	constructor:(singerId)->
		@redisClient = redisConnection.getConnections().get()['vote']
	__setKeys:(singerId)->
		@key = "singer:#{singerId}:hash" if singerId?

	getSingerInfo:(singerId,cb)->
		@__setKeys singerId
		@redisClient.hgetall @key,(err,reply)->
			return cb [] if err?
			return cb reply

	setSingerInfo:(singerInfo,singerId,cb)->
		@__setKeys singerId
		@redisClient.hmset @key,singerInfo
module.exports = Singer