const express = require('express');
const router = express.Router();

const { signupUser, getUser, isUserExist } = require('../controller/userController');

router.route('/signup').post(signupUser);
router.route('/get/user').get(getUser);
router.route('/isUserExist').get(isUserExist);

module.exports = router;