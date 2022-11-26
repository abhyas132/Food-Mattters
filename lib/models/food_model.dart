// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class Food {
  final String pushedBy;
  final bool isAvailable;
  final List<dynamic> food;
  final num foodQuantity;
  final String foodType;
  final num foodLife;
  final String photo;
  final String? id;
  final String? createdAt;
  final String? addressString;
  final List<dynamic>? requests;
  Food({
    required this.pushedBy,
    required this.isAvailable,
    required this.food,
    required this.foodQuantity,
    required this.foodType,
    required this.foodLife,
    required this.photo,
    this.id,
    this.createdAt,
    this.addressString,
    this.requests,
  });

  Food copyWith({
    String? pushedBy,
    bool? isAvailable,
    List<dynamic>? food,
    num? foodQuantity,
    String? foodType,
    num? foodLife,
    String? photo,
    String? id,
    String? createdAt,
    String? addressString,
    List<dynamic>? requests,
  }) {
    return Food(
      pushedBy: pushedBy ?? this.pushedBy,
      isAvailable: isAvailable ?? this.isAvailable,
      food: food ?? this.food,
      foodQuantity: foodQuantity ?? this.foodQuantity,
      foodType: foodType ?? this.foodType,
      foodLife: foodLife ?? this.foodLife,
      photo: photo ?? this.photo,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      addressString: addressString ?? this.addressString,
      requests: requests ?? this.requests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pushedBy': pushedBy,
      'isAvailable': isAvailable,
      'food': food,
      'foodQuantity': foodQuantity,
      'foodType': foodType,
      'foodLife': foodLife,
      'photo': photo,
      'id': id,
      'createdAt': createdAt,
      'addressString': addressString,
      'requests': requests,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      pushedBy: map['pushedBy'] as String,
      isAvailable: map['isAvailable'] as bool,
      food: List<dynamic>.from((map['food'] as List<dynamic>)),
      foodQuantity: map['foodQuantity'] as num,
      foodType: map['foodType'] as String,
      foodLife: map['foodLife'] as num,
      photo: map['photo'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      addressString: map['addressString'] != null ? map['addressString'] as String : null,
      requests: map['requests'] != null ? List<dynamic>.from((map['requests'] as List<dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Food(pushedBy: $pushedBy, isAvailable: $isAvailable, food: $food, foodQuantity: $foodQuantity, foodType: $foodType, foodLife: $foodLife, photo: $photo, id: $id, createdAt: $createdAt, addressString: $addressString, requests: $requests)';
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;
  
    return 
      other.pushedBy == pushedBy &&
      other.isAvailable == isAvailable &&
      listEquals(other.food, food) &&
      other.foodQuantity == foodQuantity &&
      other.foodType == foodType &&
      other.foodLife == foodLife &&
      other.photo == photo &&
      other.id == id &&
      other.createdAt == createdAt &&
      other.addressString == addressString &&
      listEquals(other.requests, requests);
  }
}
