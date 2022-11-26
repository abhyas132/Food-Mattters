import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Request {
  String id;
  String foodPost;
  String requestedBy;
  String requestStatus;
  String? name;
  Request({
    required this.id,
    required this.foodPost,
    required this.requestedBy,
    required this.requestStatus,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'foodPost': foodPost,
      'requestedBy': requestedBy,
      'requestStatus': requestStatus,
      'name': name,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'] as String,
      foodPost: map['foodPost'] as String,
      requestedBy: map['requestedBy'] as String,
      requestStatus: map['requestStatus'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) =>
      Request.fromMap(json.decode(source) as Map<String, dynamic>);

  Request copyWith({
    String? id,
    String? foodPost,
    String? requestedBy,
    String? requestStatus,
    String? name,
  }) {
    return Request(
      id: id ?? this.id,
      foodPost: foodPost ?? this.foodPost,
      requestedBy: requestedBy ?? this.requestedBy,
      requestStatus: requestStatus ?? this.requestStatus,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Request(id: $id, foodPost: $foodPost, requestedBy: $requestedBy, requestStatus: $requestStatus, name: $name)';
  }
}
