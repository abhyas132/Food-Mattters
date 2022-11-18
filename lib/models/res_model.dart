// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Welcome {
  Welcome({
    required this.status,
    required this.message,
    required this.user,
  });

  int status;
  String message;
  User? user;

  Welcome copyWith({
    int? status,
    String? message,
    User? user,
  }) =>
      Welcome(
        status: status ?? this.status,
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory Welcome.fromJson(String str) => Welcome.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "user": user == null ? null : user!.toMap(),
      };
}

class User {
  User({
    required this.addressPoint,
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.addressString,
    required this.documentId,
    required this.photo,
    required this.userType,
    required this.v,
  });

  AddressPoint? addressPoint;
  String id;
  String userId;
  String name;
  String phoneNumber;
  String email;
  String addressString;
  String documentId;
  String photo;
  String userType;
  int v;

  User copyWith({
    AddressPoint? addressPoint,
    String? id,
    String? userId,
    String? name,
    String? phoneNumber,
    String? email,
    String? addressString,
    String? documentId,
    String? photo,
    String? userType,
    int? v,
  }) =>
      User(
        addressPoint: addressPoint ?? this.addressPoint,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        addressString: addressString ?? this.addressString,
        documentId: documentId ?? this.documentId,
        photo: photo ?? this.photo,
        userType: userType ?? this.userType,
        v: v ?? this.v,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        addressPoint: json["addressPoint"] == null
            ? null
            : AddressPoint.fromMap(json["addressPoint"]),
        id: json["_id"] == null ? null : json["_id"],
        userId: json["userId"] == null ? null : json["userId"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        email: json["email"] == null ? null : json["email"],
        addressString:
            json["addressString"] == null ? null : json["addressString"],
        documentId: json["documentId"] == null ? null : json["documentId"],
        photo: json["photo"] == null ? null : json["photo"],
        userType: json["userType"] == null ? null : json["userType"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "addressPoint": addressPoint == null ? null : addressPoint!.toMap(),
        "_id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "addressString": addressString == null ? null : addressString,
        "documentId": documentId == null ? null : documentId,
        "photo": photo == null ? null : photo,
        "userType": userType == null ? null : userType,
        "__v": v == null ? null : v,
      };
}

class AddressPoint {
  AddressPoint({
    required this.type,
    required this.coordinates,
  });

  String? type;
  List<int>? coordinates;

  AddressPoint copyWith({
    String? type,
    List<int>? coordinates,
  }) =>
      AddressPoint(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
      );

  factory AddressPoint.fromJson(String str) =>
      AddressPoint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressPoint.fromMap(Map<String, dynamic> json) => AddressPoint(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<int>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
