const admin = require('firebase-admin');
const serviceAccount = require('../foods-matter-firebase-adminsdk-bd3ou-d3b1cfa2b3.json');
const BigPromise = require('../middleware/bigPromise');

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount)
});

exports.sendFcmNotification = BigPromise(async (req, res, next) => {

	console.log("calling sendFcmNotification");

	const registrationTokens = [
		"cdftZg6oTYqwhvuMsdHtpD:APA91bGeq6dgOVTZjigmBkk3G1yIpsiU4mLJoqc-ReCNwVAWlkO1Aq58t1pD9kJs25iTYZhwgt2YlalC3v487Eg3tYyPJ9RahKw4YWdmhbi9Is17YA7UAo2AViAoVpq4DW1eAU3GMbG_",

		"ceDTh2eyTtOozSBAt7pYlc:APA91bGAtlYuwJ5tk3-irqd8D9uXqOIMuMu0SqBKvlIqv3nldSqCnX9PWJ4ZuRMGmm_YbWW9vK-Xn1rT-04uTnlkeAExVBI66GmonF87lCZCwhGjzJ0Gs1Em589Ia13Q6id7cqQdOXP5",

		"e9WJ1QyjTyaHNlaXRftBD7:APA91bGSHsVXPTfh69tQN2GEZGN29vxHROcNs0_HAqft6ChcDTsUyouPXeOiBoFedK-ODVM9oVHU22i0G-CMk-gTalQy3jjH8KyndnhP5coPFOcDZxQ4E3_QrDBszFfJLDqsHokTPWwe"
	];

	const message = {
		notification: {
			title: 'Humble request',
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

	return res.status(200).json({
		status: 200,
		message: "Fcm function successfully called"
	});
});
