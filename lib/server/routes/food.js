const express = require('express');
const router = express.Router();

const { saveFoodPost, togglePostAvailability ,getAllMyActiveFoodPosts,getAllMyFoodPosts} = require('../controller/foodController');
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/save/request').post(isLoggedIn, saveFoodPost);
router.route('/update/request-status').put(isLoggedIn, togglePostAvailability);
router.route('/get/active-foodpost').get(isLoggedIn, getAllMyActiveFoodPosts);
router.route('/update/all-foodpost').get(isLoggedIn, getAllMyFoodPosts);

module.exports = router;
