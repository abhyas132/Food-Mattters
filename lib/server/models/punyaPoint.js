const mongoose = require('mongoose');
const validator = require('validator');

const punyaPointSchema = new mongoose.Schema({
	user: {
		type: mongoose.Schema.ObjectId,
		ref: "User"
	},
	userName: {
		type: String,
	},
	punyaPoint: {
		type: Number,
		default: 0
	}
});

module.exports = mongoose.model('PunyaPoint', punyaPointSchema);
