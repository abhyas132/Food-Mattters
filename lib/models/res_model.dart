// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
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
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        addressString: json["addressString"],
        documentId: json["documentId"],
        photo: json["photo"],
        userType: json["userType"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "addressPoint": addressPoint == null ? null : addressPoint!.toMap(),
        "_id": id,
        "userId": userId,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "addressString": addressString,
        "documentId": documentId,
        "photo": photo,
        "userType": userType,
        "__v": v,
      };
}

//TODO : debug
class AddressPoint {
  String? type;
  List<double>? coordinates;
  AddressPoint({
    this.type,
    this.coordinates,
  });

  AddressPoint copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return AddressPoint(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory AddressPoint.fromMap(Map<String, dynamic> map) {
    return AddressPoint(
      type: map['type'] != null ? map['type'] as String : null,
      coordinates: map['coordinates'] != null
          ? List<double>.from((map['coordinates'] as List<double>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressPoint.fromJson(String source) =>
      AddressPoint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AddressPoint(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(covariant AddressPoint other) {
    if (identical(this, other)) return true;

    return other.type == type && listEquals(other.coordinates, coordinates);
  }
}
