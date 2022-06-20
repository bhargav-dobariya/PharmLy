// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  Data? data;
  bool? success;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    code: json["code"],
    data: Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "success": success,
  };
}

class Data {
  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.contactNo,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? contactNo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    contactNo: json["contactNo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "contactNo": contactNo,
  };
}
