const express = require('express');
const router = express.Router();

const { saveConnection, updateConnection } = require('../controller/connectionController');

router.route('/save/connection').post(saveConnection);
router.route('/update/connection-status').put(updateConnection);

module.exports = router;