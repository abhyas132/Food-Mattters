import 'dart:convert';
import 'package:foods_matters/common/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foods_matters/models/user_model.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  void getAllUsers() async {
    List<User> listUser = [];
    print("heeelo");

    try {
      final res = await http.get(
        Uri.parse(
          "http://10.20.15.96:3000/api/v1/search/all/user?userNeeded=Consumer",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body)["users"].length; i++) {
            listUser.add(
              User.fromJson(
                jsonEncode(
                  jsonDecode(res.body)["users"][i],
                ),
              ),
            );
          }
        },
      );
      //  final resDecode = jsonDecode(res.body);

    } catch (e) {
      print(e.toString());
    }
    // return listUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: ElevatedButton(
          child: const Text("press"),
          onPressed: () {
            print("presses");
            getAllUsers();
          },
        ),
      )),
    );
  }
}
