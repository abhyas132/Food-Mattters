const express = require('express');
const router = express.Router();

const { signupUser, getUser, isUserExist, getRequestWithinRadius } = require('../controller/userController');

router.route('/signup').post(signupUser);
router.route('/get/user').get(getUser);
router.route('/isUserExist').get(isUserExist);
router.route('/notification/radius').get(getRequestWithinRadius);

module.exports = router;