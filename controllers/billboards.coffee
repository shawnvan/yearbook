BillboardHelper = require '../helpers/BillboardHelper'
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
		console.log boardData
		for value,index in boardData by 2
			console.log value,boardData[index+1]
			ret.push value
		okMsg['data'] = ret
		return res.send okMsg

module.exports.listByType = listByType