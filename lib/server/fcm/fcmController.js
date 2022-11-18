const admin = require('firebase-admin');
const serviceAccount = require('../foods-matter-firebase-adminsdk-bd3ou-d3b1cfa2b3.json');
const scheduler = require('node-schedule');
const User = require('../models/user');

const { getRequestWithinRadius } = require('../controller/userController');
const BigPromise = require('../middleware/bigPromise');


admin.initializeApp({
	credential: admin.credential.cert(serviceAccount)
});

exports.sendFcmNotification = BigPromise(async (req, res, next) => {

	// console.log("calling sendFcmNotification");

	// const registrationTokens = [
	// 	"cdftZg6oTYqwhvuMsdHtpD:APA91bGeq6dgOVTZjigmBkk3G1yIpsiU4mLJoqc-ReCNwVAWlkO1Aq58t1pD9kJs25iTYZhwgt2YlalC3v487Eg3tYyPJ9RahKw4YWdmhbi9Is17YA7UAo2AViAoVpq4DW1eAU3GMbG_",

	// 	"ceDTh2eyTtOozSBAt7pYlc:APA91bGAtlYuwJ5tk3-irqd8D9uXqOIMuMu0SqBKvlIqv3nldSqCnX9PWJ4ZuRMGmm_YbWW9vK-Xn1rT-04uTnlkeAExVBI66GmonF87lCZCwhGjzJ0Gs1Em589Ia13Q6id7cqQdOXP5",

	// 	"e9WJ1QyjTyaHNlaXRftBD7:APA91bGSHsVXPTfh69tQN2GEZGN29vxHROcNs0_HAqft6ChcDTsUyouPXeOiBoFedK-ODVM9oVHU22i0G-CMk-gTalQy3jjH8KyndnhP5coPFOcDZxQ4E3_QrDBszFfJLDqsHokTPWwe"
	// ];

	const user = req.user;

	if (!user) {
		return res.status(401).json({
			status: 401,
			message: "No such user exist, please register first"
		});
	}

	const registrationTokens = await getTokensWithinRadius(user);

	console.log(registrationTokens);

	const message = {
		notification: {
			title: 'To Shashank',
			body: 'Dekh abhi bhi time hai..Provider me switch kar lete hai'
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

			increaseRadius();
		})
		.catch((error) => {
			console.log(error);
		});

	return res.status(200).json({
		status: 200,
		message: "Fcm function successfully called"
	});
});

function increaseRadius() {
	const currTime = new Date();
	const timeToCall = currTime.getTime() + 5 * 60 * 1000;

	scheduler.scheduleJob('increaseRadius', timeToCall, callTwo);
}

function callTwo() {
	const registrationTokens = [
		"cdftZg6oTYqwhvuMsdHtpD:APA91bGeq6dgOVTZjigmBkk3G1yIpsiU4mLJoqc-ReCNwVAWlkO1Aq58t1pD9kJs25iTYZhwgt2YlalC3v487Eg3tYyPJ9RahKw4YWdmhbi9Is17YA7UAo2AViAoVpq4DW1eAU3GMbG_",

		"ceDTh2eyTtOozSBAt7pYlc:APA91bGAtlYuwJ5tk3-irqd8D9uXqOIMuMu0SqBKvlIqv3nldSqCnX9PWJ4ZuRMGmm_YbWW9vK-Xn1rT-04uTnlkeAExVBI66GmonF87lCZCwhGjzJ0Gs1Em589Ia13Q6id7cqQdOXP5",

		"e9WJ1QyjTyaHNlaXRftBD7:APA91bGSHsVXPTfh69tQN2GEZGN29vxHROcNs0_HAqft6ChcDTsUyouPXeOiBoFedK-ODVM9oVHU22i0G-CMk-gTalQy3jjH8KyndnhP5coPFOcDZxQ4E3_QrDBszFfJLDqsHokTPWwe"
	];

	const message = {
		notification: {
			title: 'Humble request after 5 mins',
			body: 'Khana de apun ko bhukh lagela hai'
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