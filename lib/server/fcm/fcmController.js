const admin = require('firebase-admin');
const serviceAccount = require('../foods-matter-firebase-adminsdk-bd3ou-d3b1cfa2b3.json');
const scheduler = require('node-schedule');
const User = require('../models/user');
const BigPromise = require('../middleware/bigPromise');

const timer = [];

//keep monitors the timer[] every 10 sec
setInterval(() => {
	timer.forEach((arr, index) => {
		if (!(timer[index] === undefined)) {
			console.log("current time inside funtion ", (new Date).getTime());

			if (arr[0] <= (new Date).getTime()) {
				console.log(arr[1]);
				sendNotification(arr[1], arr[2]); //arr[1]:tokenArray,arr[2]:notificationDetails
				delete timer[index];
			}
		}
	});
}, 10000);

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount)
});

exports.sendFcmNotification = BigPromise(async (req, res, next) => {
	const user = req.user;

	if (!user) {
		return res.status(401).json({
			status: 401,
			message: "No such user exist, please register first"
		});
	}

	const registrationTokens = await getTokensWithinRadius(user);
	// console.log(registrationTokens);

	const name = "XYZ NGO";
	const notificationTitle = "Please donate food to us";
	const notificationBody = `We are ${name}, and we are in urgent need of food`;

	notificationDetails = [notificationTitle, notificationBody];
	//Increasing radius ::
	//M1 using Node-Scheduler :
	//increaseRadius();

	//M2 using Aakash bhaiya's logic
	sendNotification(registrationTokens, notificationDetails);

	timer.push([
		(new Date).getTime() + 1000 * 60 * 2,
		registrationTokens,
		notificationDetails
	]);

	console.log(timer[0]);

	return res.status(200).json({
		status: 200,
		message: "Fcm function successfully called"
	});
});

//this function calls sendNotification() function, after 5 mins of execution
function increaseRadius() {
	const currTime = new Date();
	const timeToCall = currTime.getTime() + 5 * 60 * 1000;

	scheduler.scheduleJob('increaseRadius', timeToCall, sendNotification);
}

function sendNotification(registrationTokens, notificationDetails) {
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

async function getTokensWithinRadius(user) {
	let requiredUserType;

	if (user.userType == 'Provider') {
		requiredUserType = 'Consumer';
	}
	else {
		requiredUserType = 'Provider';
	}

	const longitude = user.addressPoint.coordinates[0];
	const latitude = user.addressPoint.coordinates[1];

	console.log("long lat ", user.addressPoint.coordinates);
	//finds all the ngos/hostels within 5kms of radius
	const options = {
		addressPoint: {
			$geoWithin: {
				$centerSphere: [[longitude, latitude], 1.60934 * 5 / 3963.2]
			}
		},
		userType: requiredUserType
	};

	const tokensWithinRadius = (await User.find(options)).map((item) => item["fcmToken"]);

	return tokensWithinRadius;
}