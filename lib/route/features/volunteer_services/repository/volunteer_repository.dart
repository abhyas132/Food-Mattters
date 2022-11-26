import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final volunteerRepositoryProvider = Provider(
  (ref) => VolunteerRepository(),
);

class VolunteerRepository {
  Future<void> sendTargetPostRequest(
      List<String> listOfSelectedPosts, String volunteerFirebaseId) async {
    Logger().d('${volunteerFirebaseId}   ${listOfSelectedPosts}');
    final res = await http.post(
      Uri.parse("${GlobalVariables.baseUrl}api/v1/save/volunteerTarget"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "volunteerFirebaseId": volunteerFirebaseId,
        "listOfSelectedPosts": listOfSelectedPosts
      }),
    );
    Logger().d(res.body);
  }
}
