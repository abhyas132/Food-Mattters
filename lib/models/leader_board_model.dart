import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LeaderBoardModel {
  String id;
  String userId;
  String userName;
  String pp;
  LeaderBoardModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.pp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'userName': userName,
      'pp': pp,
    };
  }

  factory LeaderBoardModel.fromMap(Map<String, dynamic> map) {
    return LeaderBoardModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      pp: map['pp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaderBoardModel.fromJson(String source) =>
      LeaderBoardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  LeaderBoardModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? pp,
  }) {
    return LeaderBoardModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      pp: pp ?? this.pp,
    );
  }
}
