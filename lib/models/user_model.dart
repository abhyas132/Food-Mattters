import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? userId;
  String? name;
  String? phoneNumber;
  String? email;
  String? addressString;
  double? latitude;
  double? longitude;
  String? documentId;
  String? photo;
  String? fcmToken;
  String? userType;
  User({
    this.userId,
    this.name,
    this.phoneNumber,
    this.email,
    this.addressString,
    this.latitude,
    this.longitude,
    this.documentId,
    this.photo,
    this.fcmToken,
    this.userType,
  });
  

  User copyWith({
    String? userId,
    String? name,
    String? phoneNumber,
    String? email,
    String? addressString,
    double? latitude,
    double? longitude,
    String? documentId,
    String? photo,
    String? fcmToken,
    String? userType,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      addressString: addressString ?? this.addressString,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      documentId: documentId ?? this.documentId,
      photo: photo ?? this.photo,
      fcmToken: fcmToken ?? this.fcmToken,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'addressString': addressString,
      'latitude': latitude,
      'longitude': longitude,
      'documentId': documentId,
      'photo': photo,
      'fcmToken': fcmToken,
      'userType': userType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] != null ? map['userId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      addressString: map['addressString'] != null ? map['addressString'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      documentId: map['documentId'] != null ? map['documentId'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, phoneNumber: $phoneNumber, email: $email, addressString: $addressString, latitude: $latitude, longitude: $longitude, documentId: $documentId, photo: $photo, fcmToken: $fcmToken, userType: $userType)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.name == name &&
      other.phoneNumber == phoneNumber &&
      other.email == email &&
      other.addressString == addressString &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.documentId == documentId &&
      other.photo == photo &&
      other.fcmToken == fcmToken &&
      other.userType == userType;
  }
}
