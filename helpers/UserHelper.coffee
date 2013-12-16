http = require 'http'
User = require '../models/redis/User'
class UserHelper
	token2User:(access_token,cb)->
		#get from redis first
		userModel = new User
		userModel.getUserInfoByToken access_token,(userInfo)->
			console.log userInfo
			return cb userInfo if userInfo?
			#redis miss then get from api
			#build query string
			args = 
				method:'show'
				access_token:access_token
			qs = JSON.stringify args
			options = 
				hostname:'v2.ttus.ttpod.com'
				port:80
				path:'/ttus/user'
				method:'POST'
			req = http.request options,(res)->
				_data = ''
				res.on 'data',(chunk)->
					_data += chunk
				res.on 'end',()->
					data = JSON.parse _data
					return cb null unless data['code']? and data['code'] is 1
					userInfo = data['data']
					cb userInfo
					#cache userInfo
					userModel.cacheUserInfoByToken access_token,userInfo,()->
			req.write qs
			do req.end
module.exports = UserHelper