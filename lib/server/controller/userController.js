const User = require('../models/user');
const Food = require('../models/food');
const BigPromise = require('../middleware/bigPromise');

exports.signupUser = BigPromise(async (req, res, next) => {
	//include addressPoint also 
	console.log(req.body);
	const { userId, name, phoneNumber, email, addressString, longitude, latitude, userType, documentId, photo } = req.body;
	if (!userId) {
		console.log("User is is not coming");
		return res.status(401).json({
			status: 401,
			message: "Please provide the userId of the user"
		});
	}

	//make address required 
	if (!email || !longitude || !latitude || !name || !phoneNumber || !userType) {
		return res.status(401).json({
			status: 401,
			message: "Please provide all required details including name, phoneNumber, email and address, foodType, UserType"
		});
	}

	const addressPoint = {
		type: 'Point',
		coordinates: [longitude, latitude]
	};

	const user = await User.create({
		userId,
		name,
		phoneNumber,
		email,
		addressString,
		addressPoint,
		documentId,
		photo,
		userType
	});

	//creating token :: (tokenId : userId)
	const token = user.getJwtToken();

	return res.status(200).json({
		status: 200,
		message: "User is added to database successfully.",
		token
	});
});

exports.login = BigPromise(async (req, res, next) => {
	const { phoneNumber } = req.body;

	if (!phoneNumber) {
		return res.status(401).json({
			status: 401,
			message: "Please provide phone number to login"
		});
	}

	const user = await User.findOne({ phoneNumber });

	if (!user) {
		return res.status(401).json({
			status: 401,
			message: "No such user exist, please register first"
		});
	}

	const token = user.getJwtToken();

	return res.status(200).json({
		status: 200,
		message: "Login Successful",
		user,
		token
	});
});

exports.getUser = BigPromise(async (req, res, next) => {
	const user = req.user;
	console.log("Entered in get - user controller");
	console.log("req.user ", req.user);
	console.log("req.user.id ", req.user.id);
	console.log("req.user._id ", req.user._id);

	if (!user) {
		return res.status(404).json({
			status: 404,
			message: "User does not exist"
		});
	}

	return res.status(200).json({
		status: 200,
		message: "User retrieved successfully",
		user
	});
});

exports.isUserExist = BigPromise(async (req, res, next) => {
	const phoneNumber = req.body;

	const user = await User.findOne(phoneNumber);

	if (user) {
		return res.status(200).json({
			status: 200,
			message: "User with this phone number exist",
			user,
		});
	}

	else {
		return res.status(200).json({
			status: 200,
			message: "User with this phone number does not exist",
			user,
		});
	}
});

exports.getRequestWithinRadius = BigPromise(async (req, res, next) => {

	let dataType = "user";
	let radius = 5;

	let data = await getDataWithinRadius(req.user, dataType, radius);

	console.log(data);

	return res.status(200).json({
		success: 200,
		message: "The data fetched successfully",
		data
	});
});

exports.getPostsWithinRadius = BigPromise(async (req, res, next) => {

	let dataType = "food";
	let radius = 10;

	let data = await getDataWithinRadius(req.user, dataType, radius);

	console.log(data);

	return res.status(200).json({
		success: 200,
		message: "The data fetched successfully",
		data
	});
});

async function getDataWithinRadius(user, dataType, radius) {
	if (!user) {
		return res.status(404).json({
			status: 404,
			message: "User does not exist"
		});
	}

	const longitude = user.addressPoint.coordinates[0];
	const latitude = user.addressPoint.coordinates[1];

	const options = {
		addressPoint: {
			$geoWithin: {
				$centerSphere: [[longitude, latitude], 1.60934 * radius / 3963.2]
			}
		},
		userType: "Consumer"
	};

	let data;

	if (dataType == "user") {
		data = (await User.find(options)).map((item) => item["fcmToken"]);
	}
	else {
		data = (await Food.find(options));
	}

	console.log(dataType + " " + data);

	return data;
}

exports.updateLocation = BigPromise(async (req, res, next) => {
	const { longitude, latitude } = req.body;

	if (!longitude || !latitude) {
		return res.status(401).json({
			status: 401,
			message: "Provide userId, longitude and latitude of the user"
		});
	}

	const user = await User.findById(req.user._id);

	if (!user) {
		return res.status(401).json({
			status: 401,
			message: "No such user exist"
		});
	}

	const addressPoint = {
		type: 'Point',
		coordinates: [longitude, latitude]
	};
	
	user.addressPoint = addressPoint;

	await user.save();

	return res.status(200).json({
		status: 200,
		message: "User location updated successfully"
	});
});

exports.searchUser = BigPromise(async (req, res, next) => {
	const searchTxt = req.query.expr;

	//Both the below methods work 

	// const instArr = await User.find({ name: { $regex: `\\w*${searchTxt}\\w*`, $options: 'i' } });

	const regExp = new RegExp(`\\w*${searchTxt}\\w*`, 'i');
	console.log(regExp);

	const matchedUsers = await User.find({ name: { $regex: regExp } });

	return res.status(200).json({
		status: 200,
		message: "The regex search is successful",
		matchedUsers
	});
});

exports.getAllOppositeUsers = BigPromise(async (req, res, next) => {
	const userTypeNeeded = req.query.userNeeded;

	const users = await User.find({ userType: userTypeNeeded });

	return res.status(200).json({
		status: 200,
		message: "Search successful",
		users
	});
});


