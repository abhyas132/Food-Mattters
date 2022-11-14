import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/user_repository.dart';

final userControllerProvider = Provider((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserController(userRepository: userRepository);
});

class UserController {
  final UserRepository userRepository;
  UserController({required this.userRepository});

  void selectImage(BuildContext context , bool useCamera) {
    userRepository.getImage(useCamera);
  }

} 
