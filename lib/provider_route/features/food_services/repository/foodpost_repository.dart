import 'dart:convert';
import 'dart:io';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:image_picker/image_picker.dart';
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
      //s print(res.body);
      return res.statusCode;
    } catch (e) {
      print(e.toString());
      return 404;
    }
  }

  Future<List<Food>> getMyActiveReq() async {
    List<Food> myactivefood = [];
    List<String> l = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.get(
        Uri.parse("${uri}api/v1/get/active-foodpost"),
        headers: {
          "Authorization": token!,
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        //  print(jsonDecode(res.body)["foodPosts"]);
        for (int i = 0; i < jsonDecode(res.body)["foodPosts"].length; i++) {
          final as = jsonDecode(res.body)["foodPosts"][i]["request"];
          // print(as);
          Food food = Food(
            pushedBy: jsonDecode(res.body)["foodPosts"][i]["pushedBy"],
            isAvailable: jsonDecode(res.body)["foodPosts"][i]["isAvailable"],
            food: jsonDecode(res.body)["foodPosts"][i]["food"],
            foodQuantity: jsonDecode(res.body)["foodPosts"][i]["foodQuantity"],
            foodType: jsonDecode(res.body)["foodPosts"][i]["foodType"],
            foodLife: jsonDecode(res.body)["foodPosts"][i]["foodLife"],
            photo: jsonDecode(res.body)["foodPosts"][i]["photo"] == null
                ? ""
                : jsonDecode(res.body)["foodPosts"][i]["photo"],
            id: jsonDecode(res.body)["foodPosts"][i]["_id"],
            createdAt: jsonDecode(res.body)["foodPosts"][i]["createdAt"],
            requests: jsonDecode(res.body)["foodPosts"][i]["requests"] == null
                ? l
                : jsonDecode(res.body)["foodPosts"][i]["requests"],
          );
          // print(food.requests);
          myactivefood.add(
            food,
          );
        }
      }
      // for (int i = 0; i < myactivefood.length; i++) {
      //   print(myactivefood[i]);
      // }
      //return res.statusCode;
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
      //print(res.body);
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
        Uri.parse("${uri}api/v1/update/all-foodpost"),
        headers: {
          "Authorization": token!,
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        //  print(jsonDecode(res.body)["foodPosts"]);
        for (int i = 0; i < jsonDecode(res.body)["foodPosts"].length; i++) {
          final as = jsonDecode(res.body)["foodPosts"][i]["request"];
          print(as);
          Food food = Food(
            pushedBy: jsonDecode(res.body)["foodPosts"][i]["pushedBy"],
            isAvailable: jsonDecode(res.body)["foodPosts"][i]["isAvailable"],
            food: jsonDecode(res.body)["foodPosts"][i]["food"],
            foodQuantity: jsonDecode(res.body)["foodPosts"][i]["foodQuantity"],
            foodType: jsonDecode(res.body)["foodPosts"][i]["foodType"],
            foodLife: jsonDecode(res.body)["foodPosts"][i]["foodLife"],
            photo: jsonDecode(res.body)["foodPosts"][i]["photo"] == null
                ? ""
                : jsonDecode(res.body)["foodPosts"][i]["photo"],
            id: jsonDecode(res.body)["foodPosts"][i]["_id"],
            createdAt: jsonDecode(res.body)["foodPosts"][i]["createdAt"],
            requests: jsonDecode(res.body)["foodPosts"][i]["requests"] == null
                ? l
                : jsonDecode(res.body)["foodPosts"][i]["requests"],
          );
          // print(food.requests);
          myfood.add(
            food,
          );
        }
      }
      // for (int i = 0; i < myactivefood.length; i++) {
      //   print(myactivefood[i]);
      // }
      //return res.statusCode;
    } catch (e) {
      print(e.toString());
      // return 404;
    }
    return myfood;
  }

  Future<List<Food>> getFoodFeedToConsumer() async {
    List<Food> myfood = [];
    List<String> l = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.patch(
        Uri.parse("${uri}api/v1/get/radius/foodpost"),
        headers: {
          "Authorization": token!,
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        //  print(jsonDecode(res.body)["foodPosts"]);
        for (int i = 0; i < jsonDecode(res.body)["foodPosts"].length; i++) {
          final as = jsonDecode(res.body)["foodPosts"][i]["request"];
          print(as);
          Food food = Food(
            pushedBy: jsonDecode(res.body)["foodPosts"][i]["pushedBy"],
            isAvailable: jsonDecode(res.body)["foodPosts"][i]["isAvailable"],
            food: jsonDecode(res.body)["foodPosts"][i]["food"],
            foodQuantity: jsonDecode(res.body)["foodPosts"][i]["foodQuantity"],
            foodType: jsonDecode(res.body)["foodPosts"][i]["foodType"],
            foodLife: jsonDecode(res.body)["foodPosts"][i]["foodLife"],
            photo: jsonDecode(res.body)["foodPosts"][i]["photo"] == null
                ? ""
                : jsonDecode(res.body)["foodPosts"][i]["photo"],
            id: jsonDecode(res.body)["foodPosts"][i]["_id"],
            createdAt: jsonDecode(res.body)["foodPosts"][i]["createdAt"],
            requests: jsonDecode(res.body)["foodPosts"][i]["requests"] == null
                ? l
                : jsonDecode(res.body)["foodPosts"][i]["requests"],
          );
          // print(food.requests);
          myfood.add(
            food,
          );
        }
      }
      // for (int i = 0; i < myactivefood.length; i++) {
      //   print(myactivefood[i]);
      // }
      //return res.statusCode;
    } catch (e) {
      print(e.toString());
      // return 404;
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

  void getAllMyReqAsConsumer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.get(
        Uri.parse("${uri}api/v1/get/my-request"),
        headers: {
          "Authorization": token!,
        },
      );
      print(res.body);
    } catch (e) {
      print(e.toString());
    }
  }

  void getAllMyFoodPostReq(String foodPostId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      final res = await http.get(
        Uri.parse("${uri}api/v1/get/foodpost/request?foodPostId=$foodPostId"),
        headers: {
          "Authorization": token!,
        },
      );
      print(res.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
