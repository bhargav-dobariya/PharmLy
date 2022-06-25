import 'dart:convert';

DeleteFromCartModel deleteFromCartModelFromJson(String str) => DeleteFromCartModel.fromJson(json.decode(str));

String deleteFromCartModelToJson(DeleteFromCartModel data) => json.encode(data.toJson());

class DeleteFromCartModel {
  DeleteFromCartModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory DeleteFromCartModel.fromJson(Map<String, dynamic> json) => DeleteFromCartModel(
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
