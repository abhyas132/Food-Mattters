// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:collection/collection.dart';

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
      'requests': requests,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      pushedBy: map['pushedBy'] as String,
      isAvailable: map['isAvailable'] as bool,
      food: List<String>.from((map['food'] as List<String>)),
      foodQuantity: map['foodQuantity'] as num,
      foodType: map['foodType'] as String,
      foodLife: map['foodLife'] as num,
      photo: map['photo'] as String,
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      requests: List<String>.from(
        (map['requests'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) =>
      Food.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Food(pushedBy: $pushedBy, isAvailable: $isAvailable, food: $food, foodQuantity: $foodQuantity, foodType: $foodType, foodLife: $foodLife, photo: $photo, id : $id ,createdAt: $createdAt, requests: $requests)';
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.pushedBy == pushedBy &&
        other.isAvailable == isAvailable &&
        listEquals(other.food, food) &&
        other.foodQuantity == foodQuantity &&
        other.foodType == foodType &&
        other.foodLife == foodLife &&
        other.photo == photo &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.requests == requests;
  }
}
