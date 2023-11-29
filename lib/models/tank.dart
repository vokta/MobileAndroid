// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tank {
  final String? uid;
  final String? sensorId;
  final String? sensorName;
  final String? tankBrand;
  final String? tankType;
  final String? capacity;
  final String? diameter;
  final String? height;
  Tank({
    this.uid,
    this.sensorId,
    this.sensorName,
    this.tankBrand,
    this.tankType,
    this.capacity,
    this.diameter,
    this.height,
  });

  Tank copyWith({
    String? uid,
    String? sensorId,
    String? sensorName,
    String? tankBrand,
    String? tankType,
    String? capacity,
    String? diameter,
    String? height,
  }) {
    return Tank(
      uid: uid ?? this.uid,
      sensorId: sensorId ?? this.sensorId,
      sensorName: sensorName ?? this.sensorName,
      tankBrand: tankBrand ?? this.tankBrand,
      tankType: tankType ?? this.tankType,
      capacity: capacity ?? this.capacity,
      diameter: diameter ?? this.diameter,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {
      
    };
    if (uid != null) {
      data['uid'] = uid;
    }

    if (sensorId != null) {
      data['sensorId'] = sensorId;
    }

    if (sensorName != null) {
      data['sensorName'] = sensorName;
    }

    if (tankBrand != null) {
      data['tankBrand'] = tankBrand;
    }

    if (tankType != null) {
      data['tankType'] = tankType;
    }

    if (capacity != null) {
      data['capacity'] = capacity;
    }

    if (diameter != null) {
      data['diameter'] = diameter;
    }

    if (height != null) {
      data['height'] = height;
    }

    return data;
  }

  factory Tank.fromMap(Map<String, dynamic> map) {
    return Tank(
      uid: map['uid'] != null ? map['uid'] as String : null,
      sensorId: map['sensorId'] != null ? map['sensorId'] as String : null,
      sensorName:
          map['sensorName'] != null ? map['sensorName'] as String : null,
      tankBrand: map['tankBrand'] != null ? map['tankBrand'] as String : null,
      tankType: map['tankType'] != null ? map['tankType'] as String : null,
      capacity: map['capacity'] != null ? map['capacity'] as String : null,
      diameter: map['diameter'] != null ? map['diameter'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tank.fromJson(String source) =>
      Tank.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tank(uid: $uid, sensorId: $sensorId, sensorName: $sensorName, tankBrand: $tankBrand, tankType: $tankType, capacity: $capacity, diameter: $diameter, height: $height)';
  }

  @override
  bool operator ==(covariant Tank other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.sensorId == sensorId &&
        other.sensorName == sensorName &&
        other.tankBrand == tankBrand &&
        other.tankType == tankType &&
        other.capacity == capacity &&
        other.diameter == diameter &&
        other.height == height;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        sensorId.hashCode ^
        sensorName.hashCode ^
        tankBrand.hashCode ^
        tankType.hashCode ^
        capacity.hashCode ^
        diameter.hashCode ^
        height.hashCode;
  }
}
