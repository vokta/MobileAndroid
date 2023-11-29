// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TankBrand {
  final String uid;
  final String name;

  TankBrand({
    required this.uid,
    required this.name,
  });

  TankBrand copyWith({
    String? uid,
    String? name,
  }) {
    return TankBrand(
      uid: uid ?? this.uid,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
    };
  }

  factory TankBrand.fromMap(Map<String, dynamic> map) {
    return TankBrand(
      uid: map['uid'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TankBrand.fromJson(String source) => TankBrand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TankBrand(uid: $uid, name: $name)';

  @override
  bool operator ==(covariant TankBrand other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode;
}
