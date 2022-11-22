require("dotenv").config();
var bodyParser = require("body-parser");
const express = require("express");
const app = express();
const fileUpload = require("express-fileupload");

// parse application/x-www-form-urlencoded
app.use(
  bodyParser.urlencoded({
    extended: true,
    limit: "50mb",
  })
);
// parse application/json
app.use(bodyParser.json({ limit: "50mb" }));

// app.use(fileUpload({
// 	useTempFiles: true,
// 	tempFileDir: "/tmp/"
// }));

const user = require("./routes/user");
const food = require("./routes/food");
const fcm = require("./routes/notification");
const socket = require("./routes/socket_route");

app.use("/api/v1", user);
app.use("/api/v1", food);
app.use("/api/v1", fcm);
app.use("/api/v1", socket);

module.exports = app;
