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

	//should i check if user for userId exist or not ? no

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

	const addressString = (await User.findById(req.user._id)).addressString;

	const request = await Food.create({
		pushedBy: req.user._id,
		addressString,
		isAvailable,
		food,
		foodQuantity,
		foodType,
		foodLife,
		photo,
	});

	return res.status(200).json({
		status: 200,
		message: "Food post saved successfully",
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

	const foodPosts = await Food.find({
		pushedBy: req.user._id,
		isAvailable: true
	});

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

exports.getFoodPostsWithinRadius = BigPromise(async (req, res, next) => {
	const { radius } = req.body;

	let radiusRange = 10;

	if (radius) {
		radiusRange = radius;
	}

	const user = req.user;

	const longitude = user.addressPoint.coordinates[0];
	const latitude = user.addressPoint.coordinates[1];

	console.log(longitude);
	console.log(latitude);

	const options = {
		addressPoint: {
			$geoWithin: {
				$centerSphere: [[longitude, latitude], 1.60934 * radiusRange / 3963.2]
			}
		},
		userType: "Provider"
	};

	const allUserWithinRadius = await User.find(options);

	let postWithinRadius = [];
	//see the log order 
	await allUserWithinRadius.forEach(async (user) => {
		// console.log(user.name);
		// console.log(user._id);

		const foodPost = await Food.findOne({ pushedBy: user.id, isAvailable: true });

		console.log(foodPost);

		if (foodPost)
			await postWithinRadius.push(foodPost);

		console.log(postWithinRadius);
	});

	setTimeout(() => {
		console.log("postWithing radius logging after ", postWithinRadius);

		return res.status(200).json({
			status: 200,
			message: `Posts within given radius fetched successfully`,
			postWithinRadius
		});
	}, 2000);
});

function getPostsFromUser(allUserWithinRadius) {

	let postWithinRadius = [];

	return new Promise((resolve, reject) => {
		allUserWithinRadius.forEach(async (user) => {
			// console.log(user.name);
			// console.log(user._id);

			const foodPost = await Food.findOne({ pushedBy: user.id });

			if (foodPost) {
				postWithinRadius.push(foodPost);
			}
			// console.log(postWithinRadius);
		});

		setTimeout(() => {
			resolve(postWithinRadius);
		}, 1000);

		// console.log("inside function post withing radius ", postWithinRadius);
	});
}

exports.getAllFoodPost = BigPromise(async (req, res, next) => {
	const user = req.user;

	const foodPosts = await Food.find();

	return res.status(200).json({
		status: 200,
		message: `Posts within given radius fetched successfully`,
		foodPosts
	});
});
