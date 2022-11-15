import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/features/user_services/repository/user_repository.dart';
import 'package:logger/logger.dart';

final userControllerProvider = Provider((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserController(userRepository: userRepository);
});

class UserController {
  final logger = Logger();
  final UserRepository userRepository;
  late String base64image = "";
  UserController({required this.userRepository});

  Future<void> selectImage(bool useCamera) async {
    base64image = await userRepository.getImage(useCamera) ?? "";
  }

  Future<void> registerUser({
    String? name,
    String? email,
    String? addressString,
    String? documentId,
    String? userType,
  }) async {
    try {
      await userRepository.register({
        'userId': '12', //TODO : CHANGE
        'name': name,
        'phoneNumber': '91123', //TODO : CHANGE
        'email': email,
        'addressString': addressString,
        'longitude': '1.234', //TODO : CHANGE
        'latitude': '2.1345', //TODO ; CHANGE
        'documentId': documentId,
        'userType': userType,
        'photo': base64image,
      });
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.response);
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
