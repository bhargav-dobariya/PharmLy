// To parse this JSON data, do
//
//     final diseaseModel = diseaseModelFromJson(jsonString);

import 'dart:convert';

diseaseModel diseaseModelFromJson(String str) =>
    diseaseModel.fromJson(json.decode(str));

String diseaseModelToJson(diseaseModel data) => json.encode(data.toJson());

class diseaseModel {
  diseaseModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  List<Datum>? data;
  bool? success;

  factory diseaseModel.fromJson(Map<String, dynamic> json) => diseaseModel(
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
    this.diseaseName,
    this.diseaseDescription,
  });

  String? diseaseName;
  String? diseaseDescription;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        diseaseName: json["diseaseName"],
        diseaseDescription: json["diseaseDescription"],
      );

  Map<String, dynamic> toJson() => {
        "diseaseName": diseaseName,
        "diseaseDescription": diseaseDescription,
      };
}
