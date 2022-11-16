const express = require('express');
const router = express.Router();

// routes
const { sendFcmNotification } = require('../fcm/fcmController');

// Middlewares
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/fcm/send-notification').get(isLoggedIn, sendFcmNotification);

module.exports = router;