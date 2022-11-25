const VolunteerProvider = require('../models/user');
const Food = require('../models/food');
const BigPromise = require('../middleware/bigPromise');

exports.addVolunteerTargetPost = BigPromise(async (req, res, next) => {

	const { listOfSelectedPosts, volunteerFirebaseId } = req.body;

	if (!listOfSelectedPosts || !volunteerFirebaseId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide list of selected posts and volunteerFirebaseId"
		});
	}

	const volunteerTargetPost = await VolunteerProvider.findOne({ volunteerId: volunteerFirebaseId });

	if (volunteerTargetPost) {
		const newFoodPosts = listOfSelectedPosts;
		volunteerTargetPost.foodPosts = newFoodPosts;
		await volunteerTargetPost.save();
	}
	else {
		volunteerTargetPost = await VolunteerProvider.create({
			volunteerId: volunteerFirebaseId,
			foodPosts: listOfSelectedPosts
		});
	}

	return res.status(200).json({
		status: 200,
		message: "Volunteer target posts added successfully",
		volunteerTargetPost
	});
});

exports.getAllSelectedPosts = BigPromise(async (req, res, next) => {

	const { vlounteerFirebaseId } = req.body;

	if (!volunteerFirebaseId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide volunteerFirebaseId"
		});
	}

	const allSelectedPosts = await VolunteerProvider.findOne({ volunteerId: volunteerFirebaseId }).map((volunteer) => volunteer.foodPosts);

	return res.status(200).json({
		status: 200,
		message: "Volunteer target posts added successfully",
		allSelectedPosts
	});
});

