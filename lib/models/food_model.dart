// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:foods_matters/models/user_model.dart';

class Food {
  final UserModel pushedBy;
  final bool isAvailable;
  final List<String> food;
  final num foodQuantity;
  final String foodType;
  final num foodLife;
  final String photo;
  Food({
    required this.pushedBy,
    required this.isAvailable,
    required this.food,
    required this.foodQuantity,
    required this.foodType,
    required this.foodLife,
    required this.photo,
  });

  Food copyWith({
    UserModel? pushedBy,
    bool? isAvailable,
    List<String>? food,
    num? foodQuantity,
    String? foodType,
    num? foodLife,
    String? photo,
  }) {
    return Food(
      pushedBy: pushedBy ?? this.pushedBy,
      isAvailable: isAvailable ?? this.isAvailable,
      food: food ?? this.food,
      foodQuantity: foodQuantity ?? this.foodQuantity,
      foodType: foodType ?? this.foodType,
      foodLife: foodLife ?? this.foodLife,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pushedBy': pushedBy.toMap(),
      'isAvailable': isAvailable,
      'food': food,
      'foodQuantity': foodQuantity,
      'foodType': foodType,
      'foodLife': foodLife,
      'photo': photo,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      pushedBy: UserModel.fromMap(map['pushedBy'] as Map<String,dynamic>),
      isAvailable: map['isAvailable'] as bool,
      food: List<String>.from((map['food'] as List<String>)),
      foodQuantity: map['foodQuantity'] as num,
      foodType: map['foodType'] as String,
      foodLife: map['foodLife'] as num,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Food(pushedBy: $pushedBy, isAvailable: $isAvailable, food: $food, foodQuantity: $foodQuantity, foodType: $foodType, foodLife: $foodLife, photo: $photo)';
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.pushedBy == pushedBy &&
      other.isAvailable == isAvailable &&
      listEquals(other.food, food) &&
      other.foodQuantity == foodQuantity &&
      other.foodType == foodType &&
      other.foodLife == foodLife &&
      other.photo == photo;
  }
}
