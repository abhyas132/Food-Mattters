const express = require('express');
const router = express.Router();

const { saveFoodPost, togglePostAvailability, getAllMyActiveFoodPosts,
	getAllMyFoodPosts, getFoodPostsWithinRadius, getAllFoodPost } = require('../controller/foodController');

const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/save/request').post(isLoggedIn, saveFoodPost);
router.route('/update/request-status').put(isLoggedIn, togglePostAvailability);
router.route('/get/active-foodpost').get(isLoggedIn, getAllMyActiveFoodPosts);
router.route('/get/all-foodpost').get(isLoggedIn, getAllMyFoodPosts);
router.route('/get/radius/foodpost').patch(isLoggedIn, getAllFoodPost);

module.exports = router;
