// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class User {
  final String userId;
  final String name;
  final String phone;
  final String email;
  final String addressString;
  final List<double> addressPoint;
  final String documentId;
  final String userType;
  final Photo photo;
  User({
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.addressString,
    required this.addressPoint,
    required this.documentId,
    required this.userType,
    required this.photo,
  });

  User copyWith({
    String? userId,
    String? name,
    String? phone,
    String? email,
    String? addressString,
    List<double>? addressPoint,
    String? documentId,
    String? userType,
    Photo? photo,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
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
      'phone': phone,
      'email': email,
      'addressString': addressString,
      'addressPoint': addressPoint,
      'documentId': documentId,
      'userType': userType,
      'photo': photo.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      addressString: map['addressString'] as String,
      addressPoint: List<double>.from((map['addressPoint'] as List<double>)),
      documentId: map['documentId'] as String,
      userType: map['userType'] as String,
      photo: Photo.fromMap(map['photo'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, phone: $phone, email: $email, addressString: $addressString, addressPoint: $addressPoint, documentId: $documentId, userType: $userType, photo: $photo)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.userId == userId &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.addressString == addressString &&
        listEquals(other.addressPoint, addressPoint) &&
        other.documentId == documentId &&
        other.userType == userType &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        addressString.hashCode ^
        addressPoint.hashCode ^
        documentId.hashCode ^
        userType.hashCode ^
        photo.hashCode;
  }
}

class Photo {
  final String id;
  final String secured_url;
  Photo({
    required this.id,
    required this.secured_url,
  });

  Photo copyWith({
    String? id,
    String? secured_url,
  }) {
    return Photo(
      id: id ?? this.id,
      secured_url: secured_url ?? this.secured_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'secured_url': secured_url,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'] as String,
      secured_url: map['secured_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Photo.fromJson(String source) =>
      Photo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Photo(id: $id, secured_url: $secured_url)';

  @override
  bool operator ==(covariant Photo other) {
    if (identical(this, other)) return true;

    return other.id == id && other.secured_url == secured_url;
  }

  @override
  int get hashCode => id.hashCode ^ secured_url.hashCode;
}
