billboardController = require './controllers/billboards'
module.exports = (app)->
	app.get '/',(req,res)->
		res.send 'index'
	app.get '/billboard/:boardType',billboardController.listByType

