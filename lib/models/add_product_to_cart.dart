// To parse this JSON data, do
//
//     final addProductToCartModel = addProductToCartModelFromJson(jsonString);

import 'dart:convert';

AddProductToCartModel addProductToCartModelFromJson(String str) => AddProductToCartModel.fromJson(json.decode(str));

String addProductToCartModelToJson(AddProductToCartModel data) => json.encode(data.toJson());

class AddProductToCartModel {
  AddProductToCartModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory AddProductToCartModel.fromJson(Map<String, dynamic> json) => AddProductToCartModel(
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
