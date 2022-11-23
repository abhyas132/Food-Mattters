const Food = require('../models/food');
const User = require('../models/user');
const BigPromise = require('../middleware/bigPromise');
const cloudinary = require("cloudinary").v2;

exports.saveFoodPost = BigPromise(async (req, res, next) => {
	const { isAvailable,
		food,
		foodQuantity,
		foodType,
		foodLife } = req.body;

	//should i check if user for userId exist or not ?

	if (!foodQuantity || !foodType || !foodLife) {
		return res.status(401).json({
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
		pushedBy: req.user._id,
		isAvailable,
		food,
		foodQuantity,
		foodType,
		foodLife,
		photo
	});

	return res.status(200).json({
		status: 200,
		message: "Request saved successfully",
		request
	});

});

exports.togglePostAvailability = BigPromise(async (req, res, next) => {
	const { postId, newValue } = req.body;

	//should i check if this request exist or not ?
	// console.log(req.user);

	if (!postId || !newValue) {
		return res.status(401).json({
			status: 401,
			message: "Please provide postid and newValue to update"
		});
	}

	const user = await User.findById(req.user.id);


	const request = await Food.findByIdAndUpdate(postId,
		{ isAvailable: newValue },
		{
			new: true,
			runValidators: true,
			useFindAndModify: false
		});

	if (!request) {
		return res.status(401).json({
			status: 401,
			message: "Notification not found"
		});
	}

	return res.status(200).json({
		status: 200,
		message: `Notification marked as ${newValue} successfully`,
		request
	});
});

exports.getAllMyActiveFoodPosts = BigPromise(async (req, res, next) => {

	const foodPosts = await Food.find({ pushedBy: req.user._id, isAvailable: true });

	return res.status(200).json({
		status: 200,
		message: `All the active posts are fetched successfully`,
		foodPosts
	});
});

exports.getAllMyFoodPosts = BigPromise(async (req, res, next) => {

	const foodPosts = await Food.find({ pushedBy: req.user._id });

	return res.status(200).json({
		status: 200,
		message: `All food posts are fetched successfully`,
		foodPosts
	});
});
