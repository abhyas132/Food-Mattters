import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
  });

  Future signInWithPhone(BuildContext context, String phoneNumber) async {
    await authRepository.signInWithPhone(context, phoneNumber);
  }

  Future<int> verifyOTP(
    BuildContext context,
    String verificationId,
    String userOTP,
  ) async {
    return authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }
}
