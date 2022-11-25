const express = require("express");
const router = express.Router();

const { connectToSocket } = require("../socket/socket");

router.route("/order").get(connectToSocket);

module.exports = router;
