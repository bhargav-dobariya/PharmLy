// To parse this JSON data, do
//
//     final getAddressesModel = getAddressesModelFromJson(jsonString);

import 'dart:convert';

GetAddressesModel getAddressesModelFromJson(String str) => GetAddressesModel.fromJson(json.decode(str));

String getAddressesModelToJson(GetAddressesModel data) => json.encode(data.toJson());

class GetAddressesModel {
  GetAddressesModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  List<Datum>? data;
  bool? success;

  factory GetAddressesModel.fromJson(Map<String, dynamic> json) => GetAddressesModel(
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
    this.address,
    this.area,
    this.city,
    this.pincode,
  });

  String? id;
  String? address;
  String? area;
  String? city;
  String? pincode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    address: json["address"],
    area: json["area"],
    city: json["city"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "area": area,
    "city": city,
    "pincode": pincode,
  };
}
