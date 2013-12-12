Billboards = require '../models/redis/Billboards'
class BillboardHelper
	getBillboardByType:(boardType,cb)->
		BillboardsModel = new Billboards
		return BillboardsModel.getBoards boardType,cb

	vote:(boardType,singerId,cb)->
		BillboardsModel = new Billboards
		return BillboardsModel.voteForSinger boardType,singerId,cb


module.exports = BillboardHelper