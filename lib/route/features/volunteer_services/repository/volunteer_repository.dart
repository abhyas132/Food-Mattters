// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../models/food_model.dart';

final volunteerRepositoryProvider = Provider(
  (ref) => VolunteerRepository(),
);
final logger = Logger();

class VolunteerRepository {
  Future<void> sendTargetPostRequest(
      List<String> listOfSelectedPosts, String volunteerFirebaseId) async {
    logger.d('${volunteerFirebaseId}   ${listOfSelectedPosts}');
    final res = await http.post(
      Uri.parse("${GlobalVariables.baseUrl}api/v1/save/volunteerTarget"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "volunteerFirebaseId": volunteerFirebaseId,
        "listOfSelectedPosts": listOfSelectedPosts
      }),
    );
    logger.d(res.body);
  }

  Future<List<Food>> getAllSelectedPosts(
      {required String volunteerFirebaseId}) async {
    final List<Food> myfood = [];
    logger.v('volunteers firebase uid : $volunteerFirebaseId');
    final res = (await http.patch(
        Uri.parse("${GlobalVariables.baseUrl}api/v1/get/allSelectedPosts"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "volunteerFirebaseId": volunteerFirebaseId,
        })));
    final decodedList = jsonDecode(res.body)["postList"];
    logger.d(decodedList);
    for (int i = 0; i < decodedList.length; i++) {
      final Map<String, dynamic> as = Map<String, dynamic>.from(decodedList[i]);
      Food food = Food(
        pushedBy: as["pushedBy"],
        isAvailable: as["isAvailable"],
        food: as["food"],
        foodQuantity: as["foodQuantity"],
        foodType: as["foodType"],
        foodLife: as["foodLife"],
        photo: as["photo"] ?? "",
        id: as["_id"],
        createdAt: as["createdAt"],
        requests: as["requests"] ?? [],
        addressString: as["addressString"],
      );
      myfood.add(
        food,
      );
    }
    return myfood;
  }
}
