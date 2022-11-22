const express = require("express");
const router = express.Router();

const {
  saveFoodPost,
  togglePostAvailability,
} = require("../controller/foodController");

router.route("/save/request").post(saveFoodPost);
router.route("/update/request-status").put(togglePostAvailability);

module.exports = router;
