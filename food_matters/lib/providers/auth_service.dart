import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:food_matters/models/user_model.dart';

class AuthenticationService {
  String? _verificationCode;
  String? get verificationCode => _verificationCode;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _logger = Logger();
  late final UserModel? appUser;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(userFromFirebase);
  }

  User? userFromFirebase(User? user) {
    //use this uid to fetch the data from DB and return that instead of firebase User
    //TODO : Change this to return user model
    _logger.v(user);
    populateCurrentUser(user);
    return user;
  }

  void populateCurrentUser(User? user) {
    //TODO : fetch the user model from db and use fromMap to populate the current user
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
