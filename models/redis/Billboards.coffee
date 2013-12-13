redisConnection = require '../../redisConnection'
class Billboards
	constructor:()->
		@redisClient = redisConnection.getConnections().get()['vote']

	__setKeys:(boardType)->
		@key = "board:#{boardType}:zset" if boardType?


	getBoards:(boardType,cb)->
		@__setKeys boardType
		args = [
			@key
			0
			-1
			'WITHSCORES'
		]
		@redisClient.zrevrange args,(err,reply)->
			return cb [] if err?
			return cb reply

	voteForSinger:(singerId,boardType,cb)->
		@__setKeys boardType
		args = [
			@key
			singerId
			1
		]
		@redisClient.zincrby args,(err,reply)->
			return cb null if err?
			return cb reply

module.exports = Billboards
