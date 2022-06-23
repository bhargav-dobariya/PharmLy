// To parse this JSON data, do
//
//     final addNewAdressModel = addNewAdressModelFromJson(jsonString);

import 'dart:convert';

AddNewAdressModel addNewAdressModelFromJson(String str) =>
    AddNewAdressModel.fromJson(json.decode(str));

String addNewAdressModelToJson(AddNewAdressModel data) =>
    json.encode(data.toJson());

class AddNewAdressModel {
  AddNewAdressModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  String? data;
  bool? success;

  factory AddNewAdressModel.fromJson(Map<String, dynamic> json) =>
      AddNewAdressModel(
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
