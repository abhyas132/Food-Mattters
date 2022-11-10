const express = require('express');
const router = express.Router();

const { getRequestWithinRadius } = require('../controller/foodController');

router.route('/notification/radius').get(getRequestWithinRadius);

module.exports = router;