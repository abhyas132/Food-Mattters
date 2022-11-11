const Food = require('../models/food');
const User = require('../models/user');
const BigPromise = require('../middleware/bigPromise');
const cloudinary = require("cloudinary").v2;

exports.saveFoodRequest = BigPromise(async (req, res, next) => {
	const { userId, isAvailable,
		food,
		foodQuantity,
		foodType,
		foodLife } = req.body;

	//should i check if user for userId exist or not ?

	if (!userId || !foodQuantity || !foodType || !foodLife) {
		res.status(401).json({
			status: 401,
			message: "Please provide all the necessory information required"
		});
	}

	let photo;

	if (req.files) {
		let result = await cloudinary.uploader.upload(req.files.photo.tempFilePath, {
			folder: "institutes"
		});

		photo = {
			id: result.public_id,
			secured_url: result.secure_url
		};
	}

	const request = await Food.create({
		pushedBy: userId,
		isAvailable,
		food,
		foodQuantity,
		foodType,
		foodLife,
		photo
	});

	res.status(200).json({
		status: 200,
		message: "Request saved successfully",
		request
	});

});

exports.markUnavailable = BigPromise(async (req, res, next) => {
	const { id } = req.body;

	//should i check if this request exist or not ?
	const request = await Food.findByIdAndUpdate(id, { isAvailable: false });

	if (!request) {
		res.status(401).json({
			status: 401,
			message: "Notofication not found"
		});
	}

	res.status(200).json({
		status: 200,
		message: "Notification marked unavailable successfully",
		request
	});
});