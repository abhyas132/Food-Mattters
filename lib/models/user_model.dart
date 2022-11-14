import 'dart:convert';
import 'package:flutter/foundation.dart';

class UserModel {
  final String userId;
  final String name;
  final String phoneNumber;
  final String email;
  final String addressString;
  final List<double> addressPoint;
  final String documentId;
  final String userType;
  final String photo;
  UserModel({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.addressString,
    required this.addressPoint,
    required this.documentId,
    required this.userType,
    required this.photo,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? phoneNumber,
    String? email,
    String? addressString,
    List<double>? addressPoint,
    String? documentId,
    String? userType,
    String? photo,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      addressString: addressString ?? this.addressString,
      addressPoint: addressPoint ?? this.addressPoint,
      documentId: documentId ?? this.documentId,
      userType: userType ?? this.userType,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'phone': phoneNumber,
      'email': email,
      'addressString': addressString,
      'addressPoint': addressPoint,
      'documentId': documentId,
      'userType': userType,
      'photo': photo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      phoneNumber: map['phone'] as String,
      email: map['email'] as String,
      addressString: map['addressString'] as String,
      addressPoint: List<double>.from((map['addressPoint'] as List<double>)),
      documentId: map['documentId'] as String,
      userType: map['userType'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, phone: $phoneNumber, email: $email, addressString: $addressString, addressPoint: $addressPoint, documentId: $documentId, userType: $userType, photo: $photo)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.addressString == addressString &&
        listEquals(other.addressPoint, addressPoint) &&
        other.documentId == documentId &&
        other.userType == userType &&
        other.photo == photo;
  }

}
