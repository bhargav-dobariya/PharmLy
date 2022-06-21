import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharmly/models/all_desease_model.dart';
import 'package:pharmly/models/login_model.dart';
import 'package:pharmly/models/signup_model.dart';
import 'package:pharmly/utils/api_utils.dart';

class ApiService {
  //user registration url
  static const String _userRegistrationurl = ApiUtils.baseUrl + ApiUtils.users;
  Future<SignupModel> userRegistration(
      {String? firstName,
      String? lastName,
      String? contactNo,
      String? email,
      String? password}) async {
    Map<String, dynamic> body = {
      ApiUtils.firstName: firstName,
      ApiUtils.lastName: lastName,
      ApiUtils.contactNo: contactNo,
      ApiUtils.email: email,
      ApiUtils.password: password,
    };
    // String body = json.encode(data);

    http.Response response =
        await http.post(Uri.parse(_userRegistrationurl), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return SignupModel.fromJson(mapResponse);
  }

  static const String _userLoginUrl = ApiUtils.baseUrl + ApiUtils.login;

  Future<LoginModel> userLogin({String? email, String? password}) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
      ApiUtils.password: password,
    };
    http.Response response =
        await http.post(Uri.parse(_userLoginUrl), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return LoginModel.fromJson(mapResponse);
  }

  static const String _allDesease = ApiUtils.baseUrl + ApiUtils.users;
  Future<DeseaseModel> getAllDesease() async {
    Map<String, String> header = {
      ApiUtils.authorization:
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTcwNDk4MCwiZXhwIjoxNjU1NzkxMzgwfQ.dzBnm-dRAl2msLFLZd8gKyNmlhxthGAFlATuDhvvafk'
    };
    http.Response response = await http.get(
      Uri.parse(_allDesease),
      headers: header,
    );
    Map<String, dynamic> mapResponse = json.decode(response.body);

    return DeseaseModel.fromJson(mapResponse);
  }
}
