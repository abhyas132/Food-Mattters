const express = require('express');
const router = express.Router();

const { checkAndSaveRequest, getAllRequestSentByConsumer,
	getAllRequestOnMyPost } = require('../controller/requestController');

router.route('/cheackandsave/request').post(checkAndSaveRequest);
router.route('/get/my-request').get(getAllRequestSentByConsumer);
router.route('/get/foodpost/request').get(getAllRequestOnMyPost);

module.exports = router;