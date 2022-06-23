// To parse this JSON data, do
//
//     final logOutUser = logOutUserFromJson(jsonString);

import 'dart:convert';

LogOutUser logOutUserFromJson(String str) => LogOutUser.fromJson(json.decode(str));

String logOutUserToJson(LogOutUser data) => json.encode(data.toJson());

class LogOutUser {
  LogOutUser({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory LogOutUser.fromJson(Map<String, dynamic> json) => LogOutUser(
    code: json["code"],
    data: json["data"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data,
    "success": success,
  };
}
