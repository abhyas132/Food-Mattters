const mongoose = require('mongoose');
const validator = require('validator');

const connectionSchema = new mongoose.Schema({
	providerUserId: {
		type: mongoose.Schema.ObjectId,
		ref: 'User'
	},
	consumerUserId: {
		type: mongoose.Schema.ObjectId,
		ref: 'User'
	},
	connectionStatus: {
		type: String,
		default: "Confirmed",
		enum: {
			values: ["Delievered", "Confirmed", "Cancelled"],
			message: "Please select the connection status from Delievered or Confirmed or Cancelled"
		}
	},
	foodDetails: {
		type: mongoose.Schema.ObjectId,
		ref: 'Food'
	}
});

module.exports = mongoose.model('Connection', connectionSchema);