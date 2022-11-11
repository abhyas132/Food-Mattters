const User = require('../models/user');
const BigPromise = require('../middleware/bigPromise');

exports.signupUser = BigPromise(async (req, res, next) => {
	//include addressPoint also 
	const { userId, name, phoneNumber, email, addressString, longitude, latitude, UserType, documentId, photo } = req.body;

	if (!userId) {
		console.log("User is is not coming");
		res.status(401).json({
			status: 401,
			message: "Please provide the userId of the user"
		});
	}

	//make address required 
	if (!email || !longitude || !latitude || !name || !phoneNumber || !UserType) {
		res.status(401).json({
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
		UserType
	});

	res.status(200).json({
		status: 200,
		message: "User is added to database successfully."
	});
});

exports.getUser = BigPromise(async (req, res, next) => {
	const { userId } = req.body;

	if (!userId) {
		res.status(401).json({
			status: 401,
			message: "Please provide the userId of the user"
		});
	}

	const user = await User.findOne({ userId });

	if (!user) {
		res.status(404).json({
			status: 404,
			message: "User does not exist"
		});
	}

	else {
		res.status(200).json({
			status: 200,
			message: "User retrieved successfully",
			user
		});
	}
});

exports.isUserExist = BigPromise(async (req, res, next) => {
	const phoneNumber = req.body;

	const user = await User.findOne(phoneNumber);

	if (user) {
		res.status(200).json({
			status: 200,
			message: "User with this phone number exist",
			user
		});
	}

	else {
		res.status(200).json({
			status: 200,
			message: "User with this phone number does not exist",
		});
	}
});

exports.getRequestWithinRadius = BigPromise(async (req, res, next) => {
	const { userId, userType } = req.body;

	if (!userId || !userType) {
		res.status(401).json({
			status: 401,
			message: "Please provide the userId and userType of the user"
		});
	}

	const user = await User.findOne({ userId });

	if (!user) {
		res.status(404).json({
			status: 404,
			message: "User does not exist"
		});
	}

	let requiredUserType;

	if (userType == 'Provider') {
		requiredUserType = 'Consumer';
	}
	else {
		requiredUserType = 'Provider';
	}

	const longitude = user.addressPoint.coordinates[0];
	const latitude = user.addressPoint.coordinates[1];

	//finds all the ngos/hostels within 5kms of radius
	const options = {
		addressPoint: {
			$geoWithin: {
				$centerSphere: [[longitude, latitude], 1.60934 * 5 / 3963.2]
			}
		},
		userType: requiredUserType
	};

	const UserArr = await User.find(options);

	console.log(UserArr);

	res.status(200).json({
		success: 200,
		message: "The data fetched successfully",
		UserArr
	});
});