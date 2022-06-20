import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.code,
    this.data,
    this.success,
  });

  int? code;
  Data? data;
  bool? success;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    code: json["code"],
    data: Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "success": success,
  };
}

class Data {
  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.contactNo,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? contactNo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    contactNo: json["contactNo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "contactNo": contactNo,
  };
}
