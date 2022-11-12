const express = require('express');
const router = express.Router();

const { signupUser, getUser } = require('../controller/userController');

router.route('/signup').post(signupUser);
router.route('/get/user').get(getUser);

module.exports = router;