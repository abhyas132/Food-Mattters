import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:logger/logger.dart';

import '../repository/user_repository.dart';

final userControllerProvider = Provider((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserController(userRepository: userRepository);
});

class UserController {
  final logger = Logger();
  final UserRepository userRepository;
  UserController({required this.userRepository});

  Future<void> selectImage(bool useCamera) async {
    await userRepository.getImage(useCamera);
  }

  Future<void> registerUser(String ) async {
    try {
      await userRepository.register(UserModel.fromMap({}));
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.response);
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
