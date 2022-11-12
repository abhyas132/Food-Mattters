const mongoose = require('mongoose');
const validator = require('validator');

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
		required: ['true', 'Please provide the contact number']
	},
	email: {
		type: String,
		validate: [validator.isEmail, "Please provide correct email id"],
		unique: true
	},
	address: {
		addressString: {
			type: String,
			required: ['true', "Please provide the human readable address string"]
		},
		addressPoint: {
			type: {
				type: String,
				default: "Point"
			},
			coordinates: {
				type: [Number], //[22.2475, 14.2547]  [longitude, latitude]
			},
			required: ['true', "Please provide the address coordination points"]
		},
	},
	documentId: { //check the isRequired field in frontend according to userType
		type: String,
	},
	photo: {
		id: {
			type: String,
		},
		secured_url: {
			type: String,
		}
	},
	foodType: {
		type: String,
		require: ['true', "Please provide type of food"],
		enum: {
			values: ["Veg", "Non-veg"],
			message: "Please select the food type as Veg or Non-veg only"
		}
	},
	UserType: {
		type: String,
		require: ['true', "Please provide UserType"],
		enum: {
			values: ["Provider", "Consumer"],
			message: "Please select the UserType as Provider or Consumer only"
		}
	}
});

module.exports = mongoose.model('User', userSchema);