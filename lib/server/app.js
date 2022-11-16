require('dotenv').config();

const express = require('express');
const app = express();
const fileUpload = require("express-fileupload");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(fileUpload({
	useTempFiles: true,
	tempFileDir: "/tmp/"
}));

const user = require('./routes/user');
const food = require('./routes/food');
const fcm = require('./routes/notification');

app.use('/api/v1', user);
app.use('/api/v1', food);
app.use('/api/v1', fcm);

module.exports = app;