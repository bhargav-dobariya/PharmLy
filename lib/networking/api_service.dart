import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharmly/models/all_desease_model.dart';
import 'package:pharmly/models/login_model.dart';
import 'package:pharmly/models/signup_model.dart';
import 'package:pharmly/networking/constMethod.dart';
import 'package:pharmly/utils/api_utils.dart';

class ApiService {
  var userToken = ConstantMethod.getUserAccessToken();
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

//login api
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

//disease api
  static const String _allDisease = ApiUtils.baseUrl + ApiUtils.users;
  Future<diseaseModel> getAllDisease() async {
    Map<String, String> header = {ApiUtils.authorization: userToken};
    http.Response response = await http.get(
      Uri.parse(_allDisease),
      headers: header,
    );
    Map<String, dynamic> mapResponse = json.decode(response.body);

    return diseaseModel.fromJson(mapResponse);
  }
}
