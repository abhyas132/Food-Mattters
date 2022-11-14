import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepository(Dio()));
const baseUrl = 'http://localhost:3000/';

class UserRepository {
  Dio dio;
  UserRepository(this.dio);

  Future getImage(bool userCamera) async {
    final imageSource = userCamera ? ImageSource.camera : ImageSource.gallery;
    XFile? imageFile = await ImagePicker().pickImage(source: imageSource);
    if (imageFile != null) {
      File file = File(imageFile.path);
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = const Base64Encoder().convert(imageBytes);
    } else {
      return;
    }
  }

    Future register(UserModel appUser) async{
    FormData formData = FormData.fromMap({
      'userId': 69,
      'name': 'Shanky',
      'phone': '1234567890',
      'email': 'ss@gmail.com',
      'addressString': 'addressString',
      'longitude': 1.234,
      'latitude': 2.1345,
      'documentId': 'death',
      'userType': 'Provider',
      'photo': "url",
    });
    await dio.post('${baseUrl}api/v1/signup', data: formData);
  }

}
