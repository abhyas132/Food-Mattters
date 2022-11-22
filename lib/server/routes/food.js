const express = require('express');
const router = express.Router();

const { saveFoodPost, togglePostAvailability } = require('../controller/foodController');
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/save/request').post(isLoggedIn, saveFoodPost);
router.route('/update/request-status').put(isLoggedIn, togglePostAvailability);

module.exports = router;