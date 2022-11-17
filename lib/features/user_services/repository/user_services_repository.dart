import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/error_handling.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/features/auth/screens/otp_screen.dart';
import 'package:foods_matters/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/screens/home_screen.dart';
import 'package:foods_matters/widgets/bottom_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref: ref);
});
const baseUrl = 'http://10.20.15.96:3000/';

class UserRepository {
  ProviderRef ref;
  UserRepository({
    required this.ref,
  });

  Future<String?> getImage(bool userCamera) async {
    final imageSource = userCamera ? ImageSource.camera : ImageSource.gallery;
    XFile? imageFile = await ImagePicker().pickImage(source: imageSource);
    if (imageFile != null) {
      File file = File(imageFile.path);
      List<int> imageBytes = file.readAsBytesSync();
      final base64Image = const Base64Encoder().convert(imageBytes);
      return base64Image;
    }
    return null;
  }

  Future<void> register(
      {required String? name,
      required String? email,
      required String? userId,
      required String? phoneNumber,
      required String? addressString,
      required String? longitude,
      required String? latitude,
      required String? documentId,
      required String? photo,
      required String? fcmToken,
      required String? userType,
      required BuildContext context}) async {
    User user = User(
      userId: userId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      longitude: "54",
      latitude: "6532",
      addressString: addressString,
      documentId: documentId,
      photo: photo,
      fcmToken: fcmToken,
      userType: userType,
    );
    print(user.toMap());
    try {
      final res = await http.post(
        Uri.parse('${baseUrl}api/v1/signup'),
        body: user.toMap(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          print("............${jsonDecode(res.body)['token']}...........");
          ShowSnakBar(
            context: context,
            content: 'Account created! Login with same credential',
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUserData() async {
    User? user;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token != null) {
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   OTPScreen.routeName,
        //   (route) => false,
        // );
        final res =
            await http.get(Uri.parse('${baseUrl}api/v1/get/user'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        });
        var uss = await json.decode(json.encode(res.body));
        //  print(res.body);
        ref.watch(userDataProvider).setUser(
              uss.toString(),
            );
        // print(uss);
        user = ref.watch(userDataProvider).user;
      }
    } catch (e) {
      print(e.toString());
    }
    return user;
  }
}
