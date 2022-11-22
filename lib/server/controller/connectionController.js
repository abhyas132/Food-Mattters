const mongoose = require('mongoose');
const validator = require('validator');
const Food = require('../models/food');
const Connection = require('../models/connection');
const BigPromise = require('../middleware/bigPromise');

exports.saveConnection = BigPromise(async (req, res, next) => {
	const { providerUserId, consumerUserId, foodPostId } = req.body;

	if (!providerUserId || !consumerUserId || !foodPostId) {
		return res.status(401).json({
			status: 401,
			message: "Please provide all the necessory information required"
		});
	}

	const connection = await Connection.create({
		providerUserId,
		consumerUserId,
		foodDetails: foodPostId
	});

	return res.status(200).json({
		status: 200,
		message: "Connection saved successfully",
		connection
	});
});

exports.updateConnection = BigPromise(async (req, res, next) => {
	const { connectionStatus, connectionId } = req.body;

	if (!connectionStatus) {
		return res.status(401).json({
			status: 401,
			message: "Please provide new connection status to update"
		});
	}

	const newValue = {
		connectionStatus
	};

	const connection = await Connection.findByIdAndUpdate(connectionId, newValue);

	return res.status(200).json({
		status: 200,
		message: "Connection status changed successfully",
		connection
	});
});

