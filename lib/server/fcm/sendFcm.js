const fcm = require('fcm-node');
const FCM = require('fcm-node/lib/fcm');
const serverKey = "AAAAwFfHO48:APA91bGz_fcvYBfmdMMd2DSj5RIZ79xsFsR9bO9t_5EGlFijws6g6A1CXdSp0uaqeEpemObCtf_E-tOweyzXxgI8Rh-rdCtqu3ChbjCsD-cmpla29OGh9S0B5BsNPvo-jxeDjN9ADLAf";
const BigPromise = require('../middleware/bigPromise');

exports.sendfcm = BigPromise(async (req, res, next) => {

	console.log("calling sendFcmNotification");

	try {
		let fcm = new FCM(serverKey);

		let message = {
			to: "cIF0oAJ5Q2ywNpRdQJctTp:APA91bHueeMYNuXb4gay1pjgI-PBX0F6l7frDU7qTwf7R7TMDAYtR4d7ZfjXICFyEeipXwEeCPs62NklhHAkxhAsIXirNQGfpJlBbF6sy4uX7d33_9OiOL8qslklW4MDoLr7KPvgFXjm",

			notification: {
				title: "Ganpati bappa moriya",
				body: "Ghina laadu choriya",
				sound: 'default'
			}
		};

		fcm.send(message, (error, response) => {
			if (error) {
				console.log("error occured ");
				next(error);
			} else {
				console.log("res is : ");
				res.json(response);
			}
		});
	}
	catch (error) {
		console.log("outer catch error ", error);
	}
});
