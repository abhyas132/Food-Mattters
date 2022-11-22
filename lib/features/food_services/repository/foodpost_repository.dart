import 'dart:convert';
import 'dart:io';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectid/objectid.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

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
  void addFoodPost({
    required String pushedBy,
    required bool isAvailable,
    required List<String> food,
    required num foodQuantity,
    required String foodType,
    required num foodLife,
    required String photo,
  }) async {
    try {
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
          "Content-Type": "application/json",
        },
        body: newfood.toJson(),
      );
      print(res.body);
    } catch (e) {
      rethrow;
    }
  }
}
