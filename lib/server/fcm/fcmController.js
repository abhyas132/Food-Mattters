const admin = require('firebase-admin');
const serviceAccount = require('../foods-matter-firebase-adminsdk-bd3ou-d3b1cfa2b3.json');
const BigPromise = require('../middleware/bigPromise');

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount)
});

exports.sendFcmNotification = BigPromise(async (req, res, next) => {

	console.log("calling sendFcmNotification");

	const registrationTokens = [
		"cIF0oAJ5Q2ywNpRdQJctTp:APA91bHueeMYNuXb4gay1pjgI-PBX0F6l7frDU7qTwf7R7TMDAYtR4d7ZfjXICFyEeipXwEeCPs62NklhHAkxhAsIXirNQGfpJlBbF6sy4uX7d33_9OiOL8qslklW4MDoLr7KPvgFXjm"
	];

	const message = {
		data: {
			message: "Ganpati bappa morya"
		},
		android: {
			notification: {
				color: '#7e55c3'
			}
		},
		tokens: registrationTokens
	};

	await admin.messaging().sendMulticast(message)
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

	return res.status(200).json({
		status: 200,
		message: "Fcm function successfully called"
	});
});
