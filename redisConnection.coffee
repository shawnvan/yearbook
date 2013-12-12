redis = require 'redis'
env = process.env.NODE_ENV ? 'dev'
config = require('./config')[env]
class RedisConnection
	instance = null
	class initConnections
		connections = []
		constructor:()->
			#vote redis connection
			{host,port} = config.redis.vote
			voteClient = redis.createClient port,host

			connections['vote'] = voteClient

		get:->
			connections

	@getConnections:->
		if not instance?
			instance = new initConnections
		instance

module.exports = RedisConnection