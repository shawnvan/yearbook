module.exports =
	dev:
		db: 
			uri:'mongodb://192.168.8.234:27017/tt_fav_jsrs3'
			options:
				server:
					socketOptions:
						keepAlive:1
				replset:
					rs_name:'ttrs_hz'
					socketOptions:
						keepAlive:1
		redis:
			vote:
				host: '192.168.8.220'
				port: 6379
