import 'dart:convert';

import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class ApiService{
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


  static const String getUserUrl = ApiUtils.baseUrl + ApiUtils.users + "89994fcc-8a0f-4e8a-ab02-df6ebe03e4ef";    //take id from shared preferences
  // static getUserDetails()async{
  //   final response=await http.get(Uri.parse(getUserUrl));
  //   Map<String,dynamic> mapResponse = json.decode(response.body);
  //   return Data.fromJson(mapResponse);
  // }
  Future<Data?> getUserDetails() async{
    try{
      final response=await http.get(Uri.parse(getUserUrl));
      if (response.statusCode == 200) {
        Map<String,dynamic> mapResponse = json.decode(response.body);
        return Data.fromJson(mapResponse);
        // Data dataModel = Data.fromJson(mapResponse);
        // return dataModel;
        }
      }
      catch(e){
        // print(e.toString());
    }
  }
}