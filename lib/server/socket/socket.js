const app = require("../app");
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.sendFile(__dirname + "/index.html");
});

io.on("connection", (socket) => {
  console.log(`connection successful on ${socket.id}`);

  socket.on("setup-room", (payload) => {
    var hostelId = payload.hostelId;
    var ngoId = payload.ngoId;

    socket.join(`${hostelId}`);
  });

  socket.on("order-picked", () => {
    socket.to(`${hostelId}`).emit("order-picked");
  });

  socket.on("order-cancelled", () => {
    socket.to(`${hostelId}`).emit("order-cancelled");
  });
});

server.listen(PORT, () => {
  console.log(`Socket running on port ${PORT}`);
});
