// To parse this JSON data, do
//
//     final otpResendModel = otpResendModelFromJson(jsonString);

import 'dart:convert';

OtpResendModel otpResendModelFromJson(String str) =>
    OtpResendModel.fromJson(json.decode(str));

String otpResendModelToJson(OtpResendModel data) => json.encode(data.toJson());

class OtpResendModel {
  OtpResendModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory OtpResendModel.fromJson(Map<String, dynamic> json) => OtpResendModel(
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
