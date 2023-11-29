// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TankEventResponse {
  String? uid;
  String? sensorId;
  String? sensorName;
  String? capacity;
  Events? events;
  TankEventResponse({
    this.uid,
    this.sensorId,
    this.sensorName,
    this.capacity,
    this.events,
  });

  TankEventResponse copyWith({
    String? uid,
    String? sensorId,
    String? sensorName,
    String? capacity,
    Events? events,
  }) {
    return TankEventResponse(
      uid: uid ?? this.uid,
      sensorId: sensorId ?? this.sensorId,
      sensorName: sensorName ?? this.sensorName,
      capacity: capacity ?? this.capacity,
      events: events ?? this.events,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'sensorId': sensorId,
      'sensorName': sensorName,
      'capacity': capacity,
      'events': events?.toMap(),
    };
  }

  factory TankEventResponse.fromMap(Map<String, dynamic> map) {
    return TankEventResponse(
      uid: map['uid'] != null ? map['uid'] as String : null,
      sensorId: map['sensorId'] != null ? map['sensorId'] as String : null,
      sensorName:
          map['sensorName'] != null ? map['sensorName'] as String : null,
      capacity: map['capacity'] != null ? map['capacity'] as String : null,
      events: map['events'] != null
          ? Events.fromMap(map['events'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TankEventResponse.fromJson(String source) =>
      TankEventResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TankEventResponse(uid: $uid, sensorId: $sensorId, sensorName: $sensorName, capacity: $capacity, events: $events)';
  }

  @override
  bool operator ==(covariant TankEventResponse other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.sensorId == sensorId &&
        other.sensorName == sensorName &&
        other.capacity == capacity &&
        other.events == events;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        sensorId.hashCode ^
        sensorName.hashCode ^
        capacity.hashCode ^
        events.hashCode;
  }
}

class Events {
  String? latitude;
  String? longitude;
  String? levelInLiters;
  String? levelInPercents;
  String? ph;
  String? temperature;
  String? turbidity;
  String? tds;
  String? createDt;
  Events({
    this.latitude,
    this.longitude,
    this.levelInLiters,
    this.levelInPercents,
    this.ph,
    this.temperature,
    this.turbidity,
    this.tds,
    this.createDt,
  });

  Events copyWith({
    String? latitude,
    String? longitude,
    String? levelInLiters,
    String? levelInPercents,
    String? ph,
    String? temperature,
    String? turbidity,
    String? tds,
    String? createDt,
  }) {
    return Events(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      levelInLiters: levelInLiters ?? this.levelInLiters,
      levelInPercents: levelInPercents ?? this.levelInPercents,
      ph: ph ?? this.ph,
      temperature: temperature ?? this.temperature,
      turbidity: turbidity ?? this.turbidity,
      tds: tds ?? this.tds,
      createDt: createDt ?? this.createDt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'levelInLiters': levelInLiters,
      'levelInPercents': levelInPercents,
      'ph': ph,
      'temperature': temperature,
      'turbidity': turbidity,
      'tds': tds,
      'createDt': createDt,
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      levelInLiters:
          map['levelInLiters'] != null ? map['levelInLiters'] as String : null,
      levelInPercents: map['levelInPercents'] != null
          ? map['levelInPercents'] as String
          : null,
      ph: map['ph'] != null ? map['ph'] as String : null,
      temperature:
          map['temperature'] != null ? map['temperature'] as String : null,
      turbidity: map['turbidity'] != null ? map['turbidity'] as String : null,
      tds: map['tds'] != null ? map['tds'] as String : null,
      createDt: map['createDt'] != null ? map['createDt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) =>
      Events.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Events(latitude: $latitude, longitude: $longitude, levelInLiters: $levelInLiters, levelInPercents: $levelInPercents, ph: $ph, temperature: $temperature, turbidity: $turbidity, tds: $tds, createDt: $createDt)';
  }

  @override
  bool operator ==(covariant Events other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.levelInLiters == levelInLiters &&
        other.levelInPercents == levelInPercents &&
        other.ph == ph &&
        other.temperature == temperature &&
        other.turbidity == turbidity &&
        other.tds == tds &&
        other.createDt == createDt;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        levelInLiters.hashCode ^
        levelInPercents.hashCode ^
        ph.hashCode ^
        temperature.hashCode ^
        turbidity.hashCode ^
        tds.hashCode ^
        createDt.hashCode;
  }
}
