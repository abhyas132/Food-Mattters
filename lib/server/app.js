require('dotenv').config();
var bodyParser = require('body-parser');
const express = require('express');
const app = express();
const fileUpload = require("express-fileupload");

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({
	extended: true,
	limit: '50mb'
}));

// parse application/json
app.use(bodyParser.json({ limit: '50mb' }));

// app.use(fileUpload({
// 	useTempFiles: true,
// 	tempFileDir: "/tmp/"
// }));

const user = require('./routes/user');
const food = require('./routes/food');
const fcm = require('./routes/notification');
const request = require('./routes/request');
const volunteerTarget = require('./routes/volunteerProviderRoute');
const connection = require('./routes/connectionRoute');
const socket = require("./routes/socket_route");
const punyaPoint = require("./routes/punyaPointsRoute");

app.use('/api/v1', user);
app.use('/api/v1', food);
app.use('/api/v1', fcm);
app.use('/api/v1', request);
app.use('/api/v1', connection);
app.use('/api/v1', volunteerTarget);
app.use("/api/v1", socket);
app.use("/api/v1", punyaPoint);

module.exports = app;