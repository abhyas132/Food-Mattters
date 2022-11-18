import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final uri = "http://10.20.15.96:3000";

class name extends StatefulWidget {
  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    socket = IO.io(
      uri,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build(),
    );
    socket.connect();
  }

  void emitEvents() {
    const payload = {
      'hostelId': "somerandomhostelid",
      'ngoId': "somerandomngoid"
    };
    socket.emit("setup-room", payload);

    //order completed, maybe inside setOnClick of button
    socket.emit("order-picked");
  }

  void listenToEvents() {
    socket.on("order-picked", (_) => orderPickedUpdateScreen);
    socket.on("order-cancelled", (_) => orderCancelledUpdateScreen);
  }

  void orderPickedUpdateScreen() {}

  void orderCancelledUpdateScreen() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
