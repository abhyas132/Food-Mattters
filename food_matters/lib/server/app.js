require('dotenv').config();

const express = require('express');
const app = express();
const fileupload = require('express-fileupload');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(fileupload({
	useTempFiles: true,
	tempFileDir: "/tmp/"
}));

const user = require('./routes/user');
const food = require('./routes/food');

app.use('/api/v1', user);
app.use('/api/v1', food);

module.exports = app;