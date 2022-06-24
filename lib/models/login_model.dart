// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

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
        code: json["code"] ?? null,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "code": code ?? null,
        "data": data == null ? null : data!.toJson(),
        "success": success ?? null,
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
        token: json["token"] ?? null,
        userId: json["userId"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "token": token ?? null,
        "userId": userId ?? null,
      };
}
