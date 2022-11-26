import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/error_handling.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/models/leader_board_model.dart';
import 'package:foods_matters/route/features/user_services/repository/user_provider.dart';
import 'package:foods_matters/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<User> listUser = [];
final userRepositoryProvider = Provider<UserRepository>(
  (ref) {
    return UserRepository(ref: ref);
  },
);

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

  Future<int> register(
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
      logger.i("SENDING POST REQUEST !");
      Map<String, String> postHeaders = {"Content-Type": "application/json"};
      final res = await http.post(Uri.parse('${baseUrl}api/v1/signup'),
          headers: postHeaders, body: user.toJson());

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        print("............${jsonDecode(res.body)['token']}...........");
        return 200;
      } else
        return 404;
    } catch (e) {
      logger.e("USER SERVICES REPOSITORY ------->" + e.toString());
      return 404;
      //rethrow;
    }
  }

  Future<User?> getUserData() async {
    User? user;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      // print("ye lo token $token");
      if (token != null) {
        print("token mil gya");
        final res = await http.get(
          Uri.parse('${baseUrl}api/v1/get/user'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
        );

        var aUser = jsonDecode(res.body)["user"];
        User newUser = User(
          userId: aUser["userId"],
          name: aUser["name"],
          phoneNumber: aUser["phoneNumber"],
          email: aUser["email"],
          addressString: aUser["addressString"],
          latitude: aUser["addressPoint"]["coordinates"][1],
          longitude: aUser["addressPoint"]["coordinates"][0],
          documentId: aUser["documentId"],
          photo: aUser["photo"],
          fcmToken: aUser["fcmToken"] == null ? aUser["fcmToken"] : "",
          userType: aUser["userType"],
        );

        ref.watch(userDataProvider).setUserFromModel(newUser);

        // print(newUser.name!);
        user = ref.watch(userDataProvider).user;

        final res1 = await http.get(
          Uri.parse("http://192.168.144.50:3000/api/v1/get/currUserPoints"),
          headers: {
            "Authorization": token,
          },
        );
        print(res1.body);
        if (res1.statusCode == 400) {
          ref.watch(userDataProvider).setPP("0");
        } else if (res1.statusCode == 200) {
          final points = jsonDecode(res.body)["currUserPoint"];
          ref.watch(userDataProvider).setPP(points);
        }
      } else {
        print("token not get");
      }
    } catch (e) {
      print(e.toString());
    }

    return user;
  }

  Future<List<User>> getAllUsers(String userType, bool refresh) async {
    // print("heeelo");
    userType = "Consumer";
    if (listUser.isEmpty) {
      try {
        final res = await http.get(
          Uri.parse(
            "${baseUrl}api/v1/search/all/user?userNeeded=$userType",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        //print(res.body);

        if (res.statusCode == 200) {
          var aUser = jsonDecode(res.body)["users"];
          var aaUser = jsonDecode(res.body)["users"][0]["addressPoint"]
              ["coordinates"][1];
          // print("this $aaUser");
          //   print(res.body);
          for (int i = 0; i < jsonDecode(res.body)["users"].length; i++) {
            User newUser = User(
              userId: aUser[i]["userId"],
              name: aUser[i]["name"],
              phoneNumber: aUser[i]["phoneNumber"],
              email: aUser[i]["email"],
              addressString: aUser[i]["addressString"],
              latitude: aUser[i]["addressPoint"]["coordinates"][0],
              longitude: aUser[i]["addressPoint"]["coordinates"][1],
              documentId: aUser[i]["documentId"],
              photo: aUser[i]["photo"],
              fcmToken:
                  aUser[i]["fcmToken"] == null ? aUser[i]["fcmToken"] : "",
              userType: aUser[i]["userType"],
            );
            listUser.add(
              newUser,
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
    }
    return listUser;
  }

  Future<List<User>> searchedUsers(String query) async {
    List<User> searchedlist = [];

    try {
      final res = await http.get(
        Uri.parse('${baseUrl}api/v1/search/user?expr=$query'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      var aUser = jsonDecode(res.body)["matchedUsers"];
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["matchedUsers"].length; i++) {
          User newUser = User(
            userId: aUser[i]["userId"],
            name: aUser[i]["name"],
            phoneNumber: aUser[i]["phoneNumber"],
            email: aUser[i]["email"],
            addressString: aUser[i]["addressString"],
            latitude: aUser[i]["addressPoint"]["coordinates"][0],
            longitude: aUser[i]["addressPoint"]["coordinates"][1],
            documentId: aUser[i]["documentId"],
            photo: aUser[i]["photo"],
            fcmToken: aUser[i]["fcmToken"] == null ? aUser[i]["fcmToken"] : "",
            userType: aUser[i]["userType"],
          );
          searchedlist.add(
            newUser,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return searchedlist;
  }

  Future<List<LeaderBoardModel>> getAllOnLeaderBoard() async {
    List<LeaderBoardModel> leaderBoard = [];
    try {
      final res = await http.get(
        Uri.parse(
          "http://192.168.144.50:3000/api/v1/get/leaderBoard",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(jsonDecode(res.body));
      for (int i = 0; i < jsonDecode(res.body)["allUsers"].length; i++) {
        final as = jsonDecode(res.body)["allUsers"][i];
        //print(as);
        LeaderBoardModel mm = LeaderBoardModel(
          id: as["_id"],
          userId: as["user"],
          userName: as["userName"],
          pp: as["punyaPoint"].toString(),
        );
        leaderBoard.add(mm);
      }
    } catch (e) {
      print(e.toString());
    }
    return leaderBoard;
  }
}
