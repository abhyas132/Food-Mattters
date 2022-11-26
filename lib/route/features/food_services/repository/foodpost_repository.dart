import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:foods_matters/models/request_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const uri = GlobalVariables.baseUrl;
final foodRepostitoryProvider = Provider(
  (ref) => FoodPostRepository(),
);

class FoodPostRepository {
  Future<String?> getImage(bool userCamera) async {
    final imageSource = userCamera ? ImageSource.camera : ImageSource.gallery;
    XFile? imageFile = await ImagePicker().pickImage(source: imageSource);
    if (imageFile != null) {
      File file = File(imageFile.path);
      List<int> imageBytes = file.readAsBytesSync();
      final base64Image = const Base64Encoder().convert(imageBytes);
      return base64Image;
    }
    return null;
  }

  // final User pushedBy;
  // final bool isAvailable;
  // final List<String> food;
  // final num foodQuantity;
  // final String foodType;
  // final num foodLife;
  // final String photo;
  Future<int> addFoodPost({
    required String pushedBy,
    required bool isAvailable,
    required List<String> food,
    required num foodQuantity,
    required String foodType,
    required num foodLife,
    required String photo,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      Food newfood = Food(
        pushedBy: pushedBy,
        isAvailable: isAvailable,
        food: food,
        foodQuantity: foodQuantity,
        foodType: foodType,
        foodLife: foodLife,
        photo: photo,
      );
      final res = await http.post(
        Uri.parse("${uri}api/v1/save/request"),
        headers: {
          "Authorization": token!,
          "Content-Type": "application/json",
        },
        body: newfood.toJson(),
      );
      return res.statusCode;
    } catch (e) {
      print(e.toString());
      return 404;
    }
  }

  Future<List<Food>> getMyActiveReq() async {
    List<Food> myactivefood = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.get(
        Uri.parse("${uri}api/v1/get/active-foodpost"),
        headers: {
          "Authorization": token!,
        },
      );
      if (res.statusCode == 200) {
        for (int i = 0;
            i < jsonDecode(res.body)["postWithinRadius"].length;
            i++) {
          final as = jsonDecode(res.body)["postWithinRadius"][i]["request"];
          print(as);
          Food food = Food(
            pushedBy: jsonDecode(res.body)["postWithinRadius"][i]["pushedBy"],
            isAvailable: jsonDecode(res.body)["postWithinRadius"][i]
                ["isAvailable"],
            food: jsonDecode(res.body)["postWithinRadius"][i]["food"],
            foodQuantity: jsonDecode(res.body)["postWithinRadius"][i]
                ["foodQuantity"],
            foodType: jsonDecode(res.body)["postWithinRadius"][i]["foodType"],
            foodLife: jsonDecode(res.body)["postWithinRadius"][i]["foodLife"],
            photo: jsonDecode(res.body)["postWithinRadius"][i]["photo"] ?? "",
            id: jsonDecode(res.body)["postWithinRadius"][i]["_id"],
            createdAt: jsonDecode(res.body)["postWithinRadius"][i]["createdAt"],
            requests:
                jsonDecode(res.body)["postWithinRadius"][i]["requests"] ?? [],
          );
          myactivefood.add(
            food,
          );
          log(myactivefood.length.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      // return 404;
    }
    return myactivefood;
  }

  Future<int> toggleFoodPostAvailablity(String newValue, String postId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final bdy = jsonEncode({
        "newValue": newValue,
        "postId": postId,
      });
      final res = await http.put(
        Uri.parse("${uri}api/v1/update/request-status"),
        headers: {
          "Authorization": token!,
          "Content-Type": "application/json",
        },
        body: bdy,
      );
      return res.statusCode;
    } catch (e) {
      print(e.toString());
      return 404;
    }
  }

  Future<List<Food>> getAllMyReq() async {
    List<Food> myfood = [];
    List<String> l = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.get(
        Uri.parse("${uri}api/v1/get/all-foodpost"),
        headers: {
          "Authorization": token!,
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        for (int i = 0;
            i < jsonDecode(res.body)["postWithinRadius"].length;
            i++) {
          final as = jsonDecode(res.body)["postWithinRadius"][i]["request"];
          print(as);
          Food food = Food(
            pushedBy: jsonDecode(res.body)["postWithinRadius"][i]["pushedBy"],
            isAvailable: jsonDecode(res.body)["postWithinRadius"][i]
                ["isAvailable"],
            food: jsonDecode(res.body)["postWithinRadius"][i]["food"],
            foodQuantity: jsonDecode(res.body)["postWithinRadius"][i]
                ["foodQuantity"],
            foodType: jsonDecode(res.body)["postWithinRadius"][i]["foodType"],
            foodLife: jsonDecode(res.body)["postWithinRadius"][i]["foodLife"],
            photo: jsonDecode(res.body)["postWithinRadius"][i]["photo"] ?? "",
            id: jsonDecode(res.body)["postWithinRadius"][i]["_id"],
            createdAt: jsonDecode(res.body)["postWithinRadius"][i]["createdAt"],
            requests:
                jsonDecode(res.body)["postWithinRadius"][i]["requests"] ?? l,
          );
          myfood.add(
            food,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return myfood;
  }

  Future<List<Food>> getFoodFeedToConsumer() async {
    List<Food> myfood = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.patch(
        Uri.parse("${uri}api/v1/get/radius/foodpost"),
        headers: {
          "Authorization": token!,
        },
      );
      final decodedResponse = jsonDecode(res.body)["postWithinRadius"];
      if (res.statusCode == 200) {
        for (int i = 0; i < decodedResponse.length; i++) {
          final Map<String, dynamic> as =
              Map<String, dynamic>.from(decodedResponse[i]);
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
          );
          myfood.add(
            food,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return myfood;
  }

  Future<int> reqForFood(String postId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.post(
        Uri.parse("${uri}api/v1/cheackandsave/request"),
        headers: {
          "Authorization": token!,
        },
        body: {
          "postId": postId,
        },
      );
      print(res.body);
      return res.statusCode;
    } catch (e) {
      print(e.toString());
      return 404;
    }
  }

  Future<List<Request>> getAllMyFoodPostReq(String foodPostId) async {
    List<Request> rqts = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.get(
        Uri.parse("${uri}api/v1/get/foodpost/request?foodPostId=$foodPostId"),
        headers: {
          "Authorization": token!,
        },
      );
      final food = jsonDecode(res.body)["requests"];
      for (int i = 0; i < food.length; i++) {
        Request req = Request(
          id: food[i]["_id"],
          foodPost: food[i]["foodPost"],
          requestedBy: food[i]["requestedBy"],
          requestStatus: food[i]["requestStatus"],
        );
        rqts.add(req);
        print(rqts);
      }
    } catch (e) {
      print(e.toString());
    }
    return rqts;
  }

  Future<int> CancelReq({
    required String requestId,
    required String newStatus,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.put(
        Uri.parse("${uri}api/v1/update/request/status"),
        headers: {
          "Authorization": token!,
        },
        body: {
          "requestId": requestId,
          "newStatus": newStatus,
        },
      );
      print(res.body);
      return res.statusCode;
    } catch (e) {
      print(e.toString());
      return 404;
    }
  }

  Future<List<Request>> getAllMyRequestSentAsConsumer() async {
    List<Request> rqts = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.get(
        Uri.parse("${uri}api/v1/get/my-request"),
        headers: {
          "Authorization": token!,
        },
      );
      //print(res.body);
      final food = jsonDecode(res.body)["requests"];
      for (int i = 0; i < food.length; i++) {
        Request req = Request(
          id: food[i]["_id"],
          foodPost: food[i]["foodPost"],
          requestedBy: food[i]["requestedBy"],
          requestStatus: food[i]["requestStatus"],
        );
        rqts.add(req);
        //print(rqts);
      }
    } catch (e) {
      print(e.toString());
    }
    return rqts;
  }

  
}
