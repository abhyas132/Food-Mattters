const BigPromise = require('./bigPromise');
const User = require('../models/user');
const jwt = require('jsonwebtoken');

exports.isLoggedIn = BigPromise(async (req, res, next) => {
	const token = req.header("Authorization").replace("Bearer ", "");

	if (!token) {
		return res.status(401).json({
			status: 401,
			message: "Access denied, please login first"
		});
	}

	const decode = jwt.verify(token, process.env.JWT_SECRET);

	if (!decode) {
		return res.status(401).json({
			status: 401,
			message: "Token authorization failed, Access Denied"
		});
	}

	req.user = await User.findOne({ userId: decode.tokenId });
	// console.log("req.user in middleware ", req.user);

	next();
});
