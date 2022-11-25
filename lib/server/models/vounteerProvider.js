const mongoose = require('mongoose');
const validator = require('validator');

const volunteerProviderSchema = new mongoose.Schema({
	volunteerId: {
		type: String,
		required: true
	},
	foodPosts: [
		{
			type: mongoose.Schema.ObjectId,
			ref: "Food"
		}
	]
});

module.exports = mongoose.model('VolunteerProvider', volunteerProviderSchema);
