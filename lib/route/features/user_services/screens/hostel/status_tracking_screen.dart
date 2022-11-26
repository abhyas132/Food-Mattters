import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

final uri = "http://192.168.144.50:3001";
final myuri = GlobalVariables.baseUrl;

class OrderPage extends StatefulWidget {
  //String hostelId;
  String requestId;
  OrderPage({
    //required this.hostelId,
    required this.requestId,
  });
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
    hitApi();
    connectSocket(
      requestId: widget.requestId,
    );
  }

  void hitApi() async {
    try {
      final res = await http.get(
        Uri.parse(
          "${myuri}api/v1/order",
        ),
      );
      print(jsonDecode(res.body));
    } catch (e) {
      print(e.toString());
    }
  }

  void disconnectSocket() {
    socket.disconnect();
    socket.onDisconnect((data) {
      print("disconnected");
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   disconnectSocket();
  // }

  void connectSocket({
    // required String hostelId,
    required String requestId,
  }) async {
    socket.connect();
    joinRoomAndSendData(
      //hostelId: hostelId,
      requestId: requestId,
    );
  }

  void joinRoomAndSendData({
    required String requestId,
  }) {
    final payload = {
      'requestId': requestId,
    };
    jsonEncode(payload);
    socket.emit("setup-room", payload);
  }

  void listenToEvents() {
    socket.on("order-picked", (_) => orderPickedUpdateScreen);
    socket.on("order-cancelled", (_) => orderCancelledUpdateScreen);
  }

  void orderPickedUpdateScreen() {
    //order pikced event from ngo side so it can leave the room
    socket.emit('leave-room');

    //update the UI to reflect the changes
    String user = "hostel";
    if (user == "hostel") {
    } else {}
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text("Connect to socket"),
              onPressed: () {
                connectSocket(
                  requestId: widget.requestId,
                );
              },
            ),
            MaterialButton(
              child: Text("Disconnect to socket"),
              onPressed: () {
                disconnectSocket();
              },
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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         Stack(
  //           children: [
  //             Container(
  //               width: double.infinity,
  //               height: MediaQuery.of(context).size.height * 0.4,
  //               color: Colors.blue,
  //             ),
  //             Positioned(
  //               top: MediaQuery.of(context).size.height * 0.05,
  //               //top: 20,
  //               left: MediaQuery.of(context).size.width * 0.05,
  //               child: IconButton(
  //                 icon: const Icon(
  //                   Icons.arrow_back,
  //                   color: Colors.white,
  //                 ),
  //                 onPressed: () {},
  //               ),
  //             ),
  //           ],
  //         ),

  //       ],
  //     ),
  //   );
  // }
}
