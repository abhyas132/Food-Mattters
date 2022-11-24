const express = require('express');
const router = express.Router();

<<<<<<< HEAD
const { saveFoodPost, togglePostAvailability, getAllMyActiveFoodPosts,
	getAllMyFoodPosts, getFoodPostsWithinRadius } = require('../controller/foodController');

=======
const { saveFoodPost, togglePostAvailability ,getAllMyActiveFoodPosts,getAllMyFoodPosts} = require('../controller/foodController');
>>>>>>> ce96ce395ed22ce61d80eee88ab499ca0d747d93
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/save/request').post(isLoggedIn, saveFoodPost);
router.route('/update/request-status').put(isLoggedIn, togglePostAvailability);
router.route('/get/active-foodpost').get(isLoggedIn, getAllMyActiveFoodPosts);
router.route('/get/all-foodpost').get(isLoggedIn, getAllMyFoodPosts);
router.route('/get/radius/foodpost').patch(isLoggedIn, getFoodPostsWithinRadius);

module.exports = router;
