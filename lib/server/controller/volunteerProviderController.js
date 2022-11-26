const VolunteerProvider = require('../models/vounteerProvider');
const Food = require('../models/food');
const User = require('../models/user');
const BigPromise = require('../middleware/bigPromise');
const admin = require('firebase-admin');

exports.addVolunteerTargetPost = BigPromise(async (req, res, next) => {

	const { listOfSelectedPosts, volunteerFirebaseId } = req.body;

	if (!listOfSelectedPosts || !volunteerFirebaseId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide list of selected posts and volunteerFirebaseId"
		});
	}
	
	let volunteerTargetPost = await VolunteerProvider.findOne({ volunteerId: volunteerFirebaseId });

	console.log("before saving ", volunteerTargetPost);

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

	console.log("type of variable after ", typeof (volunteerTargetPost));
	console.log("after update ", volunteerTargetPost);

	let registrationTokens = [];

	console.log("selected posts ", listOfSelectedPosts);

	await listOfSelectedPosts.forEach(async (postId) => {

		const post = await Food.findById(postId);
		const user = await User.findById(post.pushedBy);

		console.log("post ", post);
		console.log("user ", user);
		console.log("user fcmToken ", user.fcmToken);

		if (user.fcmToken)
			registrationTokens.push(user.fcmToken);
	});

	console.log("registration tokens ", registrationTokens);

	setTimeout(() => {
		sendNotification(registrationTokens, "Robinhood");

		return res.status(200).json({
			status: 200,
			message: "Volunteer target posts added successfully",
			volunteerTargetPost
		});
	}, 3000);

});

function sendNotification(registrationTokens, name) {
	const notificationDetails = ["Hey we found a match", `${name} is coming to pick the order`];
	const message = {
		notification: {
			title: notificationDetails[0],
			body: notificationDetails[1]
		},
		android: {
			notification: {
				color: '#000000'
			}
		},
		tokens: registrationTokens
	};

	admin.messaging().sendMulticast(message)
		.then((response) => {
			if (response.failureCount > 0) {
				const failedTokens = [];

				response.responses.forEach((resp, idx) => {
					if (!resp.success) {
						failedTokens.push(registrationTokens[idx]);
					}
				});
				console.log('List of tokens that caused failures: ' + failedTokens);
			}
			console.log(response.successCount + ` messages sent successfully`);
		})
		.catch((error) => {
			console.log(error);
		});
}

exports.getAllSelectedPosts = BigPromise(async (req, res, next) => {

	const { volunteerFirebaseId } = req.body;

	if (!volunteerFirebaseId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide volunteerFirebaseId"
		});
	}

	const allSelectedPosts = (await VolunteerProvider.findOne({ volunteerId: volunteerFirebaseId })).foodPosts;

	let postList = [];

	allSelectedPosts.forEach(async (postId) => {
		const post = await Food.findById(postId);
		postList.push(post);
	});

	setTimeout(() => {
		return res.status(200).json({
			status: 200,
			message: "Volunteer target posts fetched successfully",
			postList
		});
	}, 3000);

});

