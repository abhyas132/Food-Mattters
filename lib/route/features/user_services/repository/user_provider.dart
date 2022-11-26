import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/models/user_model.dart';

final userDataProvider = Provider(
  (ref) {
    return Userprovider();
  },
);

class Userprovider {
  Userprovider();
  String _points = "0";
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
  String get points => _points;
  void setPP(String points) {
    _points = points;
  }

  void setUser(String user) {
    _user = User.fromJson(user);
  }

  void setUserFromModel(User user) {
    _user = user;
  }
}
