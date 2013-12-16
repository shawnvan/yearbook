billboardController = require './controllers/billboards'
module.exports = (app)->
	app.get '/',(req,res)->
		res.send 'index'
	app.get '/billboard/:boardType',billboardController.listByType
	app.get '/candidates/:boardType',billboardController.listCandidateByType
	app.get '/vote/:boardType/:singerId/:access_token',billboardController.voteForSinger

