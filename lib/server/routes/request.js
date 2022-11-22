const express = require('express');
const router = express.Router();

const { checkAndSaveRequest, getAllRequestSentByConsumer,
	getAllRequestOnMyPost } = require('../controller/requestController');

const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/cheackandsave/request').post(isLoggedIn, checkAndSaveRequest);
router.route('/get/my-request').get(isLoggedIn, getAllRequestSentByConsumer);
router.route('/get/foodpost/request').get(getAllRequestOnMyPost);

module.exports = router;