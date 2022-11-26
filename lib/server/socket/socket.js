const app = require("../app");
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const BigPromise = require("../middleware/bigPromise");
const io = new Server(server);

const PORT = process.env.PORT || 3000;

exports.connectToSocket = BigPromise(async (req, res, next) => {
	console.log("api hit");
	server.listen(3001, () => {
		console.log(`Socket running on port 3001`);
	});
	io.on("connection", (socket) => {
		console.log(`connection successful on ${socket.id}`);
		let requestId;
		let ngoId;

		socket.on("setup-room", (payload) => {
			console.log(payload);
			//   hostelId = "someId";
			requestId = payload.requestId;
			//ngoId = payload.ngoId;

			var promise = socket.join(`${requestId}`);
		});

		socket.on("order-picked", () => {
			console.log("order picked by ngo");
			io.in(`${requestId}`).emit("order-picked");
			//update the database here by toggling the status of order to Complete
		});

		socket.on("order-cancelled", () => {
			console.log("order cancelled by hostel");
			io.in(`${requestId}`).emit("order-cancelled");
			//update the database , toggle the status of order

			//reopen the food request
		});

		socket.on("leave-room", () => {
			socket.leave(`${requestId}`);
		});
		socket.on("disconnect", () => {
			console.log("disconnected from the socket");
		});
	}); d;

	res.status(200).json({ status: 200 });
});