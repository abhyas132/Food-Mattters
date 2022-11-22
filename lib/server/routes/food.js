const express = require("express");
const router = express.Router();

const {
  saveFoodRequest,
  markUnavailable,
} = require("../controller/foodController");

router.route("/save/request").post(saveFoodRequest);
router.route("/update/request-status").put(markUnavailable);

module.exports = router;
