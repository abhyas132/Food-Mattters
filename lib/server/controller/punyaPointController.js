const PunyaPoint = require('../models/punyaPoint');
const BigPromise = require('../middleware/bigPromise');

exports.updatePoints = BigPromise(async (req, res, next) => {

	const { newPoints } = req.body;

	const newValues = await PunyaPoint.findOneAndUpdate({ user: req.user._id }, { punyaPoint: newPoints }, {
		new: true,
		runValidators: true,
		useFindAndModify: false
	});

	return res.status(200).json({
		status: 200,
		message: `Punya point of current user successfully updated.`,
		newValues
	});
});

exports.getLeaderBoard = BigPromise(async (req, res, next) => {

	const allUsers = await (await PunyaPoint.find().sort({ punyaPoint: -1 }));

	return res.status(200).json({
		status: 200,
		message: `Punya point of current user successfully updated.`,
		allUsers
	});
});
