const app = require('./app');
const connectWithDb = require('./config/db');
const cloudinary = require('cloudinary').v2;

//connect with db
connectWithDb();

const PORT = process.env.PORT || 3000;

cloudinary.config({
	cloud_name: process.env.CLOUD_NAME,
	api_key: process.env.CLOUD_API_KEY,
	api_secret: process.env.CLOUD_API_SECRET,
	secure: true
});

app.listen(PORT, "0.0.0.0", () => {
	console.log(`connected at port ${PORT}`);
})




