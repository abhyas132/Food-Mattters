import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/error_handling.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/models/res_model.dart' as resu;
import 'package:foods_matters/models/user_model.dart';
import 'package:foods_matters/widgets/bottom_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref: ref);
});

class UserRepository {
  final logger = Logger();
  ProviderRef ref;
  String baseUrl = GlobalVariables.baseUrl;
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
      required double? longitude,
      required double? latitude,
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
      longitude: longitude,
      latitude: latitude,
      addressString: addressString,
      documentId: documentId,
      photo: photo,
      fcmToken: fcmToken,
      userType: userType,
    );
    try {
      logger.i("SENDING POST REQUEST !") ;
      Map<String, String> postHeaders = {"Content-Type": "application/json"};
      final res = await http.post(Uri.parse('${baseUrl}api/v1/signup'),
          headers: postHeaders, body: user.toJson());
          
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
      logger.e("USER SERVICES REPOSITORY ------->" + e.toString());
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
        final res = await http.get(
          Uri.parse('${baseUrl}api/v1/get/user'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
        );
        var uss = await json.decode(json.encode(res.body));
        //final o = jsonDecode(resu.Welcome.fromJson(uss).user);
        User newUser = User(
          userId: resu.Welcome.fromJson(uss).user!.userId,
          name: resu.Welcome.fromJson(uss).user!.name,
          phoneNumber: resu.Welcome.fromJson(uss).user!.phoneNumber,
          email: resu.Welcome.fromJson(uss).user!.email,
          addressString: resu.Welcome.fromJson(uss).user!.addressString,
          latitude:
              resu.Welcome.fromJson(uss).user!.addressPoint!.coordinates![0],
          longitude:
              resu.Welcome.fromJson(uss).user!.addressPoint!.coordinates![1],
          documentId: resu.Welcome.fromJson(uss).user!.documentId,
          photo: resu.Welcome.fromJson(uss).user!.photo,
          fcmToken: "",
          userType: resu.Welcome.fromJson(uss).user!.userType,
        );
        // print(token);
        ref.watch(userDataProvider).setUserFromModel(
              newUser,
            );

        user = ref.watch(userDataProvider).user;
        // print();
        //ref.watch(userDataProvider).setUser(res.body);
        // print(user.fcmToken);
      }
    } catch (e) {
      print(e.toString());
    }
    return user;
  }

  Future<List<User>> getAllUsers(String userType) async {
    List<User> listUser = [];
    print("heeelo");

    try {
      final res = await http.get(
        Uri.parse(
          "http://10.20.15.96:3000/api/v1/search/all/user?userNeeded=$userType",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["users"].length; i++) {
          listUser.add(
            User.fromJson(
              jsonEncode(
                jsonDecode(res.body)["users"][i],
              ),
            ),
          );
          // print(jsonEncode(
          //   jsonDecode(res.body)["users"][i],
          // ));
        }
      }
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     for (int i = 0; i < jsonDecode(res.body)["users"].length; i++) {
      //       listUser.add(
      //         User.fromJson(
      //           jsonEncode(
      //             jsonDecode(res.body)["users"][i],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // );
      //  final resDecode = jsonDecode(res.body);

    } catch (e) {
      print(e.toString());
    }
    return listUser;
  }
}
