Candidate = require '../models/redis/Candidate'
Singer = require '../models/redis/Singer'
async = require 'async'
class CandidateHelper
	getCandidates:(boardType,cb)->
		candidateModel = new Candidate
		candidateModel.getCandidateByType boardType,(reply)=>
			#if get data ,return 
			return cb reply if reply
			#else get singers and build candidates data
			candidateModel.getSingerByType boardType,(singerIds)=>
				singerInfos = {}
				hasData = false
				singerModel = new Singer
				_f = (singerId,cb)->
					singerModel.getSingerInfo singerId,(reply)->
						if reply?
							singerInfos[singerId] = reply 
							hasData = true
						do cb
				async.each singerIds,_f,(err)->
					return cb -1 if err?
					candidateModel.cacheCandidateByType singerInfos,boardType if hasData
					return cb singerInfos

	verifySinger:(singerId,boardType,cb)->
		candidateModel = new Candidate
		candidateModel.verifySinger singerId,boardType,cb


module.exports = CandidateHelper