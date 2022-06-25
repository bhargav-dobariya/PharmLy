// To parse this JSON data, do
//
//     final diseaseProduct = diseaseProductFromJson(jsonString);

import 'dart:convert';

DiseaseProduct diseaseProductFromJson(String str) =>
    DiseaseProduct.fromJson(json.decode(str));

String diseaseProductToJson(DiseaseProduct data) => json.encode(data.toJson());

class DiseaseProduct {
  DiseaseProduct({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  List<Datum>? data;
  bool? success;

  factory DiseaseProduct.fromJson(Map<String, dynamic> json) => DiseaseProduct(
        code: json["code"] ?? null,
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "code": code ?? null,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success ?? null,
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
        id: json["id"] ?? null,
        title: json["title"] ?? null,
        companyName: json["companyName"] ?? null,
        price: json["price"] ?? null,
        productImage: json["productImage"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "title": title ?? null,
        "companyName": companyName ?? null,
        "price": price ?? null,
        "productImage": productImage ?? null,
      };
}
