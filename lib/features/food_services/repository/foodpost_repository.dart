import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';

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
}
