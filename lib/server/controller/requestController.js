const Request = require('../models/request');
const Food = require('../models/food');
const BigPromise = require('../middleware/bigPromise');

exports.checkAndSaveRequest = BigPromise(async (req, res, next) => {
	const { postId } = req.body;

	if (!postId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide both PostId"
		});
	}

	const foodPost = await Food.findById(postId);

	if (!foodPost) {
		return res.status(404).json({
			status: 404,
			message: "No such food post exist"
		});
	}

	const options = {
		foodPost,
		requestedBy: req.user
	};

	const isExist = await Food.findOne(options);

	console.log(isExist);

	if (isExist) {
		return res.status(403).json({
			status: 403,
			message: "You already have sent food request to this hostel"
		});
	}

	const request = await Request.create({
		foodPost: postId,
		requestedBy: req.user._id,
	});

	foodPost.requests.push(req.user._id);

	await foodPost.save({ validateBeforeSave: false });

	return res.status(200).json({
		status: 200,
		message: "Request sent successfully",
		request
	});
});

exports.updateRequestStatus = BigPromise(async (req, res, next) => {
	const { requestId, newStatus } = req.body;

	if (!requestId || !newStatus) {
		return res.status(401).json({
			status: 401,
			message: "Please provide both requestId and newStatus"
		});
	}

	const newValue = {
		requestStatus: newStatus
	};

	const request = await Request.findByIdAndUpdate(requestId, newValue, {
		new: true,
		runValidators: true,
		useFindAndModify: false
	});

	return res.status(200).json({
		status: 200,
		message: "Request status updated successfully",
		request
	});

});

exports.getAllRequestSentByConsumer = BigPromise(async (req, res, next) => {
	// const requestedByUserId = req.query.userId;

	// if (!requestedByUserId) {
	// 	return res.status(401).json({
	// 		status: 401,
	// 		message: "Please provide requestedByUserId"
	// 	});
	// }

	const query = {
		requestedBy: req.user._id
	};

	const requests = await Request.find(query);

	return res.status(200).json({
		status: 200,
		message: "All requests by a consumer fetched successfully",
		requests
	});
});

exports.getAllRequestOnMyPost = BigPromise(async (req, res, next) => {
	const foodPostId = req.query.foodPostId;

	if (!foodPostId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide foodPostId"
		});
	}

	const query = {
		foodPost: foodPostId
	};

	const requests = await Request.find(query);

	return res.status(200).json({
		status: 200,
		message: "All requests on a given post fetched successfully",
		requests
	});
});
