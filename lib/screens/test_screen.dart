import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/error_handling.dart';
import 'package:foods_matters/provider_route/features/food_services/repository/foodpost_repository.dart';
import 'package:foods_matters/provider_route/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
      final res = await http.patch(
          Uri.parse(
            "http://10.20.15.96:3000/api/v1/login",
          ),
          body: {"phoneNumber": "+917023888838"});
      print(jsonDecode(res.body)["token"]);

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
          child: const Text("presss"),
          onPressed: () {
            print("presses");
            ref.watch(foodRepostitoryProvider).getMyActiveReq();
          },
        ),
      )),
    );
  }
}
