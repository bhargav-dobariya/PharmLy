// To parse this JSON data, do
//
//     final otpVerificationModel = otpVerificationModelFromJson(jsonString);

import 'dart:convert';

OtpVerificationModel otpVerificationModelFromJson(String str) =>
    OtpVerificationModel.fromJson(json.decode(str));

String otpVerificationModelToJson(OtpVerificationModel data) =>
    json.encode(data.toJson());

class OtpVerificationModel {
  OtpVerificationModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  Data? data;
  bool? success;

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      OtpVerificationModel(
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
