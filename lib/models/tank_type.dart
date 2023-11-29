// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TankType {
  final String uid;
  final String name;
  final String capacity;
  final String diameter;
  final String height;

  TankType({
    required this.uid,
    required this.name,
    required this.capacity,
    required this.diameter,
    required this.height,
  });

  TankType copyWith({
    String? uid,
    String? name,
    String? capacity,
    String? diameter,
    String? height,
  }) {
    return TankType(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      diameter: diameter ?? this.diameter,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'capacity': capacity,
      'diameter': diameter,
      'height': height,
    };
  }

  factory TankType.fromMap(Map<String, dynamic> map) {
    return TankType(
      uid: map['uid'] as String,
      name: map['name'] as String,
      capacity: map['capacity'] as String,
      diameter: map['diameter'] as String,
      height: map['height'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TankType.fromJson(String source) =>
      TankType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TankType(uid: $uid, name: $name, capacity: $capacity, diameter: $diameter, height: $height)';
  }

  @override
  bool operator ==(covariant TankType other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.capacity == capacity &&
        other.diameter == diameter &&
        other.height == height;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        capacity.hashCode ^
        diameter.hashCode ^
        height.hashCode;
  }
}
