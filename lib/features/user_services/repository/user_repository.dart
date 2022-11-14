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
  late String base64Image ;
  UserRepository(this.dio);

  Future getImage(bool userCamera) async {
    final imageSource = userCamera ? ImageSource.camera : ImageSource.gallery;
    XFile? imageFile = await ImagePicker().pickImage(source: imageSource);
    if (imageFile != null) {
      File file = File(imageFile.path);
      List<int> imageBytes = file.readAsBytesSync();
      base64Image = const Base64Encoder().convert(imageBytes);
    } else {
      return;
    }
  }

  Future register(UserModel appUser) async {
    FormData formData = FormData.fromMap({
      'userId': appUser.userId,
      'name': appUser.name,
      'phoneNumber': appUser.phoneNumber,
      'email': 'ss@gmail.com',
      'addressString': appUser.addressString,
      'longitude': 1.234,
      'latitude': 2.1345,
      'documentId': appUser.documentId,
      'userType': appUser.userType,
      'photo': base64Image,
    });
    try {
      await dio.post('${baseUrl}api/v1/signup', data: formData);
    } catch (e) {
      rethrow;
    }
  }

}
