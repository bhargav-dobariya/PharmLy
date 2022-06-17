// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  SignupModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
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
