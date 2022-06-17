import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharmly/utils/api_utils.dart';

class ApiService {
  //user registration url
  static const String _userRagistrationurl = ApiUtils.baseUrl + ApiUtils.users;
  static userRegistration(
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
        await http.post(Uri.parse(_userRagistrationurl), body: body);
    return json.decode(response.body);
  }

  static const String _userLoginUrl = ApiUtils.baseUrl + ApiUtils.users;

  static userLogin({String? email, String? password}) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
      ApiUtils.password: password,
    };
    http.Response response =
        await http.post(Uri.parse(_userLoginUrl), body: body);
    return json.decode(response.body);
  }
}
