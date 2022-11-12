require('dotenv').config();

const express = require('express');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const user = require('./routes/user');

app.use('/api/v1', user);

module.exports = app;