Vote = require '../models/redis/Vote'
Billboards = require '../models/redis/Billboards'
Candidate = require '../models/redis/Candidate'
class VoteHelper
	vote:(boardType,singerId,tuid,cb)->
		voteModel = new Vote
		voteTimes = voteModel.getVoteTimes tuid,(reply)->
			#redis err or vote by max
			return cb null if reply is -1 or reply > 4
			#verify singer
			candidateModel = new Candidate
			candidateModel.verifySinger singerId,boardType,(result)->
				return cb null unless result
				#vote
				billboardsModel = new Billboards
				billboardsModel.voteForSinger singerId,boardType,(result)->
					return cb null unless result
					#add user vote times
					voteModel.addVoteTimes tuid,(result)->
						return cb null unless result
						cb true
module.exports = VoteHelper