import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

final uri = "http://10.200.37.89:3001";

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
  }

  void disconnectSocket() {
    socket.disconnect();

    socket.onDisconnect((data) => log("Disconnected from socket"));
  }

  void connectSocket() async {
    try {
      final res = await http.get(Uri.parse(
        "http://10.200.37.89:3000/api/v1/order",
      ));
      print(jsonDecode(res.body)["token"]);
    } catch (e) {
      print(e.toString());
    }
    socket.connect();
    joinRoomAndSendData();
  }

  void joinRoomAndSendData() {
    const payload = {
      'hostelId': "somerandomhostelid",
      'ngoId': "somerandomngoid"
    };
    socket.emit("setup-room", payload);
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

  void completeOrder() {
    socket.emit("order-picked");
  }

  void cancelOrder() {
    socket.emit("order-cancelled");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text("Connect to socket"),
              onPressed: connectSocket,
            ),
            MaterialButton(
              child: Text("Disconnect to socket"),
              onPressed: disconnectSocket,
            ),
            MaterialButton(
                child: Text("Complete the order"), onPressed: completeOrder),
            MaterialButton(
                child: Text("Cancel the order"), onPressed: cancelOrder)
          ],
        ),
      ),
    );
  }
}
