BillboardHelper = require '../helpers/BillboardHelper'
CandidateHelper = require '../helpers/CandidateHelper'
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

module.exports.listByType = listByType
module.exports.listCandidateByType = listCandidateByType