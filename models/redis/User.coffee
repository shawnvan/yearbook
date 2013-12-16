redisConnection = require '../../redisConnection'
class User
	constructor:()->
		@redisClient = redisConnection.getConnections().get()['vote']

	__setKeys:(access_token)->
		@key  = "user:#{access_token}:info"

	getUserInfoByToken:(access_token,cb)->
		@__setKeys access_token
		@redisClient.hgetall @key,(err,reply)->
			return cb null if err?
			cb reply

	cacheUserInfoByToken:(access_token,userInfo,cb)->
		@__setKeys access_token
		@redisClient.hmset @key,userInfo,(err,reply)->
			return cb null if err?
			@redisClient.expire @key,60*60*24
			return cb reply
module.exports = User