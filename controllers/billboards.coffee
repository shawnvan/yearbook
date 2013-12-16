BillboardHelper = require '../helpers/BillboardHelper'
CandidateHelper = require '../helpers/CandidateHelper'
VoteHelper = require '../helpers/VoteHelper'
UserHelper = require '../helpers/UserHelper'
errMsg = 
	code : 1
	msg : 'error'

okMsg =
	code : 1
	data : []

listByType = (req,res)->
	#return if boardType not passed
	return res.send errMsg unless req.params.boardType?
	billboardHelper = new BillboardHelper
	billboardHelper.getBillboardByType req.params.boardType,(boardData)->
		ret = []
		for value,index in boardData by 2
			ret.push value
		okMsg['data'] = ret
		return res.send okMsg

listCandidateByType = (req,res)->
	return res.send errMsg unless req.params.boardType?
	candidateHelper = new CandidateHelper
	data = []
	candidateHelper.getCandidates req.params.boardType,(candiates)->
		okMsg['data'] = candiates
		res.send okMsg

#/vote/:boardType/:singerId/:accessToken
voteForSinger = (req,res)->
	return res.send errMsg unless req.params.boardType and req.params.singerId and req.params.access_token
	#token to user
	userHelper = new UserHelper
	userHelper.token2User req.params.access_token,(result)->
		return res.send errMsg unless result? and result['tuid']?
		tuid = result['tuid']
		voteHelper = new VoteHelper
		voteHelper.vote req.params.boardType,req.params.singerId,req.params.tuid,(result)->
			return res.send errMsg unless result? and result
			res.send okMsg


module.exports.listByType = listByType
module.exports.listCandidateByType = listCandidateByType
module.exports.voteForSinger = voteForSinger