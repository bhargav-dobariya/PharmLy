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
    this.errorMessage,
    this.error,
    this.data,
    this.success,
  });

  int? code;
  String? errorMessage;
  Error? error;
  dynamic? data;
  bool? success;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"] ?? null,
        errorMessage: json["errorMessage"] ?? null,
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
        data: json["data"],
        success: json["success"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "code": code ?? null,
        "errorMessage": errorMessage ?? null,
        "error": error == null ? null : error?.toJson(),
        "data": data,
        "success": success ?? null,
      };
}

class Error {
  Error();

  factory Error.fromJson(Map<String, dynamic> json) => Error();

  Map<String, dynamic> toJson() => {};
}
