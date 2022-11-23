import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/models/user_model.dart';

final userDataProvider = Provider(
  (ref) {
    return Userprovider();
  },
);

class Userprovider {
  Userprovider();
  User _user = User(
    userId: '',
    name: '',
    phoneNumber: '',
    email: '',
    addressString: '',
    latitude: null,
    longitude: null,
    documentId: '',
    photo: '',
    fcmToken: '',
    userType: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
  }

  void setUserFromModel(User user) {
    _user = user;
  }
}
