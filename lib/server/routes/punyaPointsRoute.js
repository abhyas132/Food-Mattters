const express = require('express');
const router = express.Router();

const { updatePoints, getLeaderBoard } = require('../controller/punyaPointController');
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/update/punyaPoint').put(isLoggedIn, updatePoints);
router.route('/get/leaderBoard').get(getLeaderBoard);

module.exports = router;