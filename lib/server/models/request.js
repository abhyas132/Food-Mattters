const mongoose = require('mongoose');

const validator = require('validator');

const requestSchema = new mongoose.Schema({
	foodPost: {
		type: mongoose.Schema.ObjectId,
		ref: "Food"
	},
	requestedBy: {
		type: mongoose.Schema.ObjectId,
		ref: "User"
	},
	requestStatus: {
		type: String,
		default: "Waiting",
		enum: {
			values: ["Waiting", "Accepted", "Declined"],
			message: "Please select the requestStatus from given enum only"
		}
	}
});

module.exports = mongoose.model('Request', requestSchema);
