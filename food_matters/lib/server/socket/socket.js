const app = require('../app');
const http = require('http');
const server = http.createServer(app);

var io = require('socket.io')(server);

io.on('connection', (socket) => {
	console.log('socket connection');

	socket.on('onNotificationPushed', () => {

	});

});