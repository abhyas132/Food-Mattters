import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

final uri = "http://192.168.1.10:3001";

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _orderPageState();
}

class _orderPageState extends State<OrderPage> {
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

  void disconnectSocket() {
    socket.disconnect();

    socket.onDisconnect((data) => log("Disconnected from socket"));
  }

  void connectSocket() async {
    try {
      final res = await http.get(Uri.parse(
        "http://192.168.1.10:3000/api/v1/order",
      ));
      print(jsonDecode(res.body)["token"]);
    } catch (e) {
      print(e.toString());
    }
  }

  void emitEvents() {
    const payload = {
      'hostelId': "somerandomhostelid",
      'ngoId': "somerandomngoid"
    };
    socket.emit("setup-room", payload);

    //order completed, maybe inside setOnClick of button only from hostel side
    // socket.emit("order-picked");

    //order cancelled, maybe inside setOnClick of button
    // socket.emit("order-cancelled");
  }

  void listenToEvents() {
    socket.on("order-picked", (_) => orderPickedUpdateScreen);
    socket.on("order-cancelled", (_) => orderCancelledUpdateScreen);
  }

  void orderPickedUpdateScreen() {
    //order pikced event from ngo side so it can leave the room
    socket.emit('leave-room');
  }

  void orderCancelledUpdateScreen() {
    //order cancelled event from ngo side so it can leave the room
    socket.emit('leave-room');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              child: Text("Connect to socket"),
              onPressed: connectSocket,
            ),
            TextButton(
              child: Text("Disconnect to socket"),
              onPressed: disconnectSocket,
            )
          ],
        ),
      ),
    );
  }
}
