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
  Future<UserProfile?> getUserDetails() async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTcwNDk4MCwiZXhwIjoxNjU1NzkxMzgwfQ.dzBnm-dRAl2msLFLZd8gKyNmlhxthGAFlATuDhvvafk'
      };
      final response = await http.get(Uri.parse(getUserUrl),headers: header);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String,dynamic> mapResponse = json.decode(response.body);
        return UserProfile.fromJson(mapResponse);
        // Data dataModel = Data.fromJson(mapResponse);
        // return dataModel;
      }
    }
    catch(e){
      // print(e.toString());
      return UserProfile();
    }
  }

  Future<UserProfile?> updateUserDetails({
    String? firstName,
    String? lastName,
    String? contactNo,
  })async{
    Map<String,dynamic> body={
      ApiUtils.firstName: firstName,
      ApiUtils.lastName: lastName,
      ApiUtils.contactNo: contactNo,
    };

    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTcwNDk4MCwiZXhwIjoxNjU1NzkxMzgwfQ.dzBnm-dRAl2msLFLZd8gKyNmlhxthGAFlATuDhvvafk'
      };
      http.Response response=await http.put(Uri.parse(getUserUrl),headers:header,body: body);

      if(response.statusCode==200){
        return UserProfile.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
      // return UserProfile();
    }
  }
}