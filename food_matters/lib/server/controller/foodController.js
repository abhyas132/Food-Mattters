const Food = require('../models/food');
const User = require('../models/user');
const BigPromise = require('../middleware/bigPromise');

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