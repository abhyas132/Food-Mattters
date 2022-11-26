import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/error_handling.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  void getAllUsers() async {
    List<User> listUser = [];
    print("heeelo");

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('x-auth-token');
      final res = await http.patch(
        Uri.parse("${uri}api/v1/get/radius/foodpost"),
        headers: {
          "Authorization": token!,
        },
      );
      Logger().d(res.body);
      //  final resDecode = jsonDecode(res.body);
      // print(res.body);
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
          child: const Text("presss"),
          onPressed: () async {
            print("presses");

            // ref.watch(foodRepostitoryProvider).getAllMyReqAsConsumer();
          },
        ),
      )),
    );
  }
}
