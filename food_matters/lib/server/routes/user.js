const express = require('express');
const router = express.Router();

// routes
const { signupUser, getUser, isUserExist, getRequestWithinRadius } = require('../controller/userController');

// Middlewares
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/signup').post(signupUser);
router.route('/get/user').get(isLoggedIn, getUser);
router.route('/isUserExist').get(isUserExist);
router.route('/notification/radius').get(getRequestWithinRadius);

module.exports = router;