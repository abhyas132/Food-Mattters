const mongoose = require('mongoose');
require('dotenv').config();
const connectWithDb = () => {
	mongoose.connect("mongodb+srv://abhyas132:abhyas132@cluster0.qcv2gij.mongodb.net/?retryWrites=true&w=majority", {
		useNewUrlParser: true,
		useUnifiedTopology: true
	})
		.then(console.log(`DB CONNECTED SUCCESSFULLY`))
		.catch((error) => {
			console.log(`DB CONNECTION ERROR`);
			console.log(error);
			process.exit(1);
		});
};

module.exports = connectWithDb;