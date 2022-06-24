import 'dart:convert';

DeleteUserModel deleteUserModelFromJson(String str) => DeleteUserModel.fromJson(json.decode(str));

String deleteUserModelToJson(DeleteUserModel data) => json.encode(data.toJson());

class DeleteUserModel {
  DeleteUserModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory DeleteUserModel.fromJson(Map<String, dynamic> json) => DeleteUserModel(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : json["data"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data,
    "success": success == null ? null : success,
  };
}
