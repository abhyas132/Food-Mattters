import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/route/features/user_services/repository/user_services_repository.dart';

import 'package:foods_matters/models/user_model.dart';
import 'package:logger/logger.dart';

final userControllerProvider = Provider(
  (ref) {
    final userRepository = ref.watch(userRepositoryProvider);
    return UserController(userRepository: userRepository);
  },
);

final userDataControllerProvider =
    FutureProvider((ref) => ref.watch(userControllerProvider).getUserData());
// final userAllDataControllerProvider = FutureProvider(
//   (ref) => ref.watch(userControllerProvider).getAllUsers("Consumer"),
// );

class UserController {
  final logger = Logger();
  final UserRepository userRepository;
  late String base64image = "";
  UserController({required this.userRepository});

  Future<void> selectImage(bool useCamera) async {
    base64image = await userRepository.getImage(useCamera) ?? "";
  }

  Future<int> registerUser({
    required String? name,
    required String? email,
    required String? userId,
    required String? phoneNumber,
    required String? addressString,
    required double? latitude,
    required double? longitude,
    required String? documentId,
    required String? fcmToken,
    required String? userType,
    required BuildContext context,
  }) async {
    try {
      return await userRepository.register(
        name: name,
        email: email,
        latitude: latitude,
        longitude: longitude,
        addressString: addressString,
        userId: userId,
        userType: userType,
        documentId: documentId,
        phoneNumber: phoneNumber,
        photo: base64image,
        fcmToken: fcmToken,
        context: context,
      );
    } catch (e) {
      ShowSnakBar(
        context: context,
        content: e.toString(),
      );
      return 404;
      // logger.e(e);
    }
  }

  Future<User?> getUserData() async {
    print("object");
    User? user = await userRepository.getUserData();
    return user;
  }

  Future<List<User?>> getAllUsers(String userType, bool refresh) async {
    return await userRepository.getAllUsers(userType, refresh);
  }

  Future<List<User?>> searchedUsers(String q) async {
    return await userRepository.searchedUsers(q);
  }
}
