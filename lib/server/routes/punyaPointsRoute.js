const express = require('express');
const router = express.Router();

const { updatePoints, getLeaderBoard, fetchPointForUser } = require('../controller/punyaPointController');
const { isLoggedIn } = require('../middleware/userMiddleware');

router.route('/update/punyaPoint').put(isLoggedIn, updatePoints);
router.route('/get/leaderBoard').get(getLeaderBoard);
router.route('/get/currUserPoints').get(isLoggedIn, fetchPointForUser);

module.exports = router;