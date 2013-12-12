os = require 'os'
cluster = require 'cluster'
if cluster.isMaster
	threadCount = os.cpus().length
	threadCount = 1
	do cluster.fork while threadCount--
else
	express = require 'express'
	fs = require 'fs'
	mongoose = require 'mongoose'
	async = require 'async'
	http = require 'http'
	env = process.env.NODE_ENV ? 'dev'
	config = require('./config')[env]
	mongoose.connect config.db.uri,config.db.options
	modelsPath = './models/mongo'
	modelFiles = fs.readdirSync modelsPath
	for file in modelFiles
		require modelsPath+'/'+file
	app = do express
	app.use express.bodyParser()
	#routes
	routes = require './routes'
	routes app
	port = process.env.PORT ? 3000
	app.listen port

	console.log 'Express start on port:'+port
	exports = module.exports = app
	console.log cluster.worker.id

	cluster.on 'exit',(worker)->
		console.log worker.id,' died'
		do cluster.fork