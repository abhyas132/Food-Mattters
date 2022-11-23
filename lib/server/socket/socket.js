const app = require("../app");
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const BigPromise = require("../middleware/bigPromise");
const io = new Server(server);

const PORT = process.env.PORT || 3000;

exports.connectToSocket = BigPromise(async (req, res, next) => {

	server.listen(3001, () => {
		console.log('socket running on port 3001');
	});

	console.log("api hit");
	io.on("connection", (socket) => {
		console.log(`connection successful on ${socket.id}`);
		let hostelId;
		let ngoId;

		socket.on("setup-room", (payload) => {
			console.log(payload);
			hostelId = "someId";
		});
		// hostelId = payload.hostelId;
		// ngoId = payload.ngoId;


		socket.on("order-picked", () => {
			console.log("order picked by ngo");
			io.in(`${hostelId}`).emit("order-picked");
			//update the database here by toggling the status of order to Complete
		});

		socket.on("order-cancelled", () => {
			console.log("order cancelled from hostel side");
			io.in(`${hostelId}`).emit("order-cancelled");
			//update the database , toggle the status of order

			//reopen the food request
		});

		socket.on("leave-room", () => {
			console.log("user left the room");
			socket.leave(`${hostelId}`);
		});
	});

	io.on("disconnect", () => {
		console.log("Disconnected from socket");
	});

	res.status(200).json({ status: 200 });
});
