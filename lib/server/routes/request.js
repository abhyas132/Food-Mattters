const express = require('express');
const router = express.Router();

const { checkAndSaveRequest, updateRequestStatus, getAllRequestSentByConsumer,
	getAllRequestOnMyPost } = require('../controller/requestController');

const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/cheackandsave/request').post(isLoggedIn, checkAndSaveRequest);
router.route('/update/request/status').put(isLoggedIn, updateRequestStatus);
router.route('/get/my-request').get(isLoggedIn, getAllRequestSentByConsumer);
router.route('/get/foodpost/request').get(isLoggedIn, getAllRequestOnMyPost);

module.exports = router;