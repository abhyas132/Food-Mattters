const express = require('express');
const router = express.Router();

// routes
const { sendFcmNotification } = require('../fcm/fcmController');
const { sendfcm } = require('../fcm/sendFcm');

// Middlewares
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/fcm/send-notification').get(isLoggedIn, sendFcmNotification);
router.route('/fcm/send').post(sendfcm);

module.exports = router;