// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {

  final String? uid;
  final String? fullname;
  final String firstname;
  final String lastname;
  final String email;
  final String mobileNo;
  final String address;
  final String? password;

  User({
    this.uid,
    this.fullname,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobileNo,
    required this.address,
    this.password,
  });

  User copyWith({
    String? uid,
    String? fullname,
    String? firstname,
    String? lastname,
    String? email,
    String? mobileNo,
    String? address,
    String? password,
  }) {
    return User(
      uid: uid ?? this.uid,
      fullname: fullname ?? this.fullname,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      mobileNo: mobileNo ?? this.mobileNo,
      address: address ?? this.address,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'mobileNo': mobileNo,
      'address': address,
    };

    if (uid != null) {
      data['uid'] = uid;
    }

    if (fullname != null) {
      data['fullname'] = fullname;
    }

    if (password != null) {
      data['password'] = password;
    }

    return data;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] != null ? map['uid'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      mobileNo: map['mobileNo'] as String,
      address: map['address'] as String,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, fullname: $fullname, firstname: $firstname, lastname: $lastname, email: $email, mobileNo: $mobileNo, address: $address, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.fullname == fullname &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.email == email &&
      other.mobileNo == mobileNo &&
      other.address == address &&
      other.password == password;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      fullname.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      mobileNo.hashCode ^
      address.hashCode ^
      password.hashCode;
  }
}
