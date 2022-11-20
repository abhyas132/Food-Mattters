const Request = require('../models/request');
const Food = require('../models/food');
const BigPromise = require('../middleware/bigPromise');

exports.checkAndSaveRequest = BigPromise(async (req, res, next) => {
	const { postId, requestedByUserId } = req.body;

	if (!postId || !requestedByUserId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide both PostId and requestedByUserId"
		});
	}

	const foodPost = await Food.findById(postId);

	foodPost.requests.forEach((requestId) => {
		if (requestId === requestedByUserId) {
			return res.status(403).json({
				status: 403,
				message: "You already have sent food request to this hostel"
			});
		}
	});

	const request = await Request.create({
		foodPost: postId,
		requestedBy: requestedByUserId,
	});

	foodPost.requests.push(requestedByUserId);

	await foodPost.save({ validateBeforeSave: false });

	return res.status(200).json({
		status: 200,
		message: "Request sent successfully",
	});
});

exports.updateRequestStatus = BigPromise(async (req, res, next) => {
	const { requestId, newStatus } = req.body();

	if (!requestId || !newStatus) {
		return res.status(401).json({
			status: 401,
			message: "Please provide both requestId and newStatus"
		});
	}

	const newValue = {
		requestStatus: newStatus
	};

	const request = await Request.findByIdAndUpdate(requestId, newValue);

	return res.status(200).json({
		status: 200,
		message: "Request status updated successfully",
	});

});

exports.getAllRequestSentByConsumer = BigPromise(async (req, res, next) => {
	const requestedByUserId = req.query.userId;

	if (!requestedByUserId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide requestedByUserId"
		});
	}

	const query = {
		requestedBy: requestedByUserId
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
