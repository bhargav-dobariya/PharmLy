// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  List<Datum>? data;
  bool? success;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
    this.title,
    this.companyName,
    this.price,
    this.productImage,
  });

  String? id;
  String? title;
  String? companyName;
  String? price;
  String? productImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    companyName: json["companyName"],
    price: json["price"],
    productImage: json["productImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "companyName": companyName,
    "price": price,
    "productImage": productImage,
  };
}
