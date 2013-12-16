redisConnection = require '../../redisConnection'
class Candidate
	constructor:(boardType)->
		@redisClient = redisConnection.getConnections().get()['vote']
		@__setKeys boardType
	__setKeys:(boardType)->
		if boardType?
			@key = "candidate:#{boardType}:val" 
			@singerSetKey = "candidate:#{boardType}:set"

	getCandidateByType:(boardType,cb)->
		@__setKeys boardType
		@redisClient.get @key,(err,reply)->
			return cb null if err?
			return cb JSON.parse reply

	cacheCandidateByType:(candidates,boardType,cb)->
		@__setKeys boardType
		@redisClient.set @key,JSON.stringify(candidates),(err,reply)->
			return cb null if err?
			return cb reply

	getSingerByType:(boardType,cb)->
		@__setKeys boardType
		@redisClient.smembers @singerSetKey,(err,reply)->
			return cb [] if err?
			return cb reply

	addSingerByType:(singerIds,boardType,cb)->
		@__setKeys boardType
		for singerId in singerIds
			@redisClient.sadd @key,singerId

	verifySinger:(singerId,boardType,cb)->
		@__setKeys boardType
		@redisClient.sismember singerId,(err,reply)->
			return cb false if err?
			cb reply

module.exports = Candidate
