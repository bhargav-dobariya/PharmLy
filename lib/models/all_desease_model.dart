// To parse this JSON data, do
//
//     final diseaseModel = diseaseModelFromJson(jsonString);

import 'dart:convert';

DiseaseModel diseaseModelFromJson(String str) =>
    DiseaseModel.fromJson(json.decode(str));

String diseaseModelToJson(DiseaseModel data) => json.encode(data.toJson());

class DiseaseModel {
  DiseaseModel({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  List<Datum?>? data;
  bool? success;

  factory DiseaseModel.fromJson(Map<String, dynamic> json) => DiseaseModel(
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x?.toJson())),
        "success": success,
      };
}

class Datum {
  Datum({
    this.id,
    this.diseaseName,
    this.diseaseDescription,
  });

  String? id;
  String? diseaseName;
  String? diseaseDescription;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        diseaseName: json["diseaseName"],
        diseaseDescription: json["diseaseDescription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "diseaseName": diseaseName,
        "diseaseDescription": diseaseDescription,
      };
}
