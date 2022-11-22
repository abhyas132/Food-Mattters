const app = require("../app");
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const BigPromise = require("../middleware/bigPromise");
const io = new Server(server);

const PORT = process.env.PORT || 3000;

exports.connectToSocket = BigPromise(async (req, res, next) => {
  console.log("api hit");
  io.on("connection", (socket) => {
    console.log(`connection successful on ${socket.id}`);
    let hostelId;
    let ngoId;

    socket.on("setup-room", (payload) => {
      console.log(payload);
      hostelId = "someId";
      // hostelId = payload.hostelId;
      // ngoId = payload.ngoId;

      socket.join(`${hostelId}`);
    });

    socket.on("order-picked", () => {
      io.in(`${hostelId}`).emit("order-picked");
      //some calculations (if any)
    });

    socket.on("order-cancelled", () => {
      io.in(`${hostelId}`).emit("order-cancelled");
      //some calculations (if any)
    });

    socket.on("leave-room", () => {
      socket.leave(`${hostelId}`);
    });
  });

  server.listen(3001, () => {
    console.log(`Socket running on port 3001`);
  });

  res.status(200).json({ status: 200 });
});
