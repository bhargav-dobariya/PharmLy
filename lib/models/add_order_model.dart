// To parse this JSON data, do
//
//     final addOrderModel = addOrderModelFromJson(jsonString);

import 'dart:convert';

AddOrderModel addOrderModelFromJson(String str) => AddOrderModel.fromJson(json.decode(str));

String addOrderModelToJson(AddOrderModel data) => json.encode(data.toJson());

class AddOrderModel {
  AddOrderModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory AddOrderModel.fromJson(Map<String, dynamic> json) => AddOrderModel(
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
