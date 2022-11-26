const express = require('express');
const router = express.Router();

// routes
const { addVolunteerTargetPost, getAllSelectedPosts } = require('../controller/volunteerProviderController');

// Middlewares
const { isLoggedIn } = require('../middleware/userMiddleware');

// router.route('/save/volunteerTarget').post(isLoggedIn, addVolunteerTargetPost);
router.route('/save/volunteerTarget').post(addVolunteerTargetPost);
// router.route('/get/allSelectedPosts').get(isLoggedIn, getAllSelectedPosts);
router.route('/get/allSelectedPosts').patch(getAllSelectedPosts);

module.exports = router;

