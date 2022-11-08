import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthenticationService {
  String? _verificationCode;
  String? get verificationCode => _verificationCode;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  User? _userFromFirebase(User? user) {
    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signinWithOTP(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91 $phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        var userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        if (userCredential.user != null) {
          _logger.v("LOGGED IN ");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        _logger.e(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationCode = verificationId;
        _logger.d(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}