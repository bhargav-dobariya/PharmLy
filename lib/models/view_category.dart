// To parse this JSON data, do
//
//     final viewCategory = viewCategoryFromJson(jsonString);

import 'dart:convert';

ViewCategory viewCategoryFromJson(String str) => ViewCategory.fromJson(json.decode(str));

String viewCategoryToJson(ViewCategory data) => json.encode(data.toJson());

class ViewCategory {
  ViewCategory({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  List<Datum>? data;
  bool? success;

  factory ViewCategory.fromJson(Map<String, dynamic> json) => ViewCategory(
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
  };
}

class Datum {
  Datum({
    this.id,
    this.categoryName,
    this.categoryImage,
  });

  String? id;
  String? categoryName;
  String? categoryImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "categoryImage": categoryImage,
  };
}
