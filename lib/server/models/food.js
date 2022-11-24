const mongoose = require('mongoose');
const validator = require('validator');

const foodSchema = new mongoose.Schema({
	pushedBy: {
		type: mongoose.Schema.ObjectId,
		ref: 'User',
		require: ['true', "Please provide notification id"]
	},
	isAvailable: {
		type: Boolean,
		default: true,
		require: ['true', "Please provide notification status available or not"]
	},
	food: [{
		type: String,
	}],
	foodQuantity: {
		type: Number,
		require: ['true', "Please provide the food quantity"]
	},
	foodType: {
		type: String,
		require: ['true', "Please provide the food type"],
		enum: {
			values: ["Veg", "Non-veg"],
			message: "Please select the foodType as Veg or Non-veg only"
		}
	},
	foodLife: {
		type: Number,
		require: ['true', "Please provide the approx food life in hours"],
	},
	photo: {
		type: String
	},
	createdAt: {
		type: Date,
		default: Date.now
	},
	requests: [{
		type: mongoose.Schema.ObjectId,
		ref: 'User'
	}]
});

module.exports = mongoose.model('Food', foodSchema);
