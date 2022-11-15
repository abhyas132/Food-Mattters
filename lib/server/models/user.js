const mongoose = require('mongoose');
const validator = require('validator');
const jwt = require('jsonwebtoken');

const userSchema = new mongoose.Schema({
	userId: {
		type: String,
		required: ['true', "Please provide the userId"]
	},
	name: {
		type: String,
		required: ['true', "Please provide name of the institute"]
	},
	phoneNumber: {
		type: String,
		unique: true,
		required: ['true', 'Please provide the contact number']
	},
	email: {
		type: String,
		validate: [validator.isEmail, "Please provide correct email id"],
		unique: true
	},
	addressString: {
		type: String,
		required: ['true', "Please provide the human readable address string"]
	},
	addressPoint: {
		type: {
			type: String,
			default: 'Point'
		},
		coordinates: {
			type: [Number], //[22.2475, 14.2547]  [longitude, latitude]
		},
	},
	documentId: { //check the isRequired field in frontend according to userType
		type: String,
	},
	photo: {
		type: String
	},
	fcmToken: { //make this required afterwards
		type: String
	},
	userType: {
		type: String,
		require: ['true', "Please provide UserType"],
		enum: {
			values: ["Provider", "Consumer"],
			message: "Please select the UserType as Provider or Consumer only"
		}
	}
});

userSchema.methods.getJwtToken = function () {
	return jwt.sign(
		{ tokenId: this.userId },
		process.env.JWT_SECRET
	);
};

module.exports = mongoose.model('User', userSchema);