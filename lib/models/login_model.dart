// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  Data? data;
  bool? success;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.token,
    this.userId,
  });

  String? token;
  String? userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userId": userId,
      };
}
