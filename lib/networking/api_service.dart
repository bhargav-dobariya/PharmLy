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
import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/models/update_user_profile.dart';
import 'package:pharmly/models/view_category.dart';
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
        await http.post(Uri.parse(_userRegistrationurl), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return SignupModel.fromJson(mapResponse);
  }

//login api
  static const String _userLoginUrl = ApiUtils.baseUrl + ApiUtils.login;

  Future<LoginModel> userLogin({String? email, String? password}) async {
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

    await http.post(Uri.parse(_userLoginUrl), body: body);
    return json.decode(response.body);
  }


  static const String getUserUrl = ApiUtils.baseUrl + ApiUtils.users + "89994fcc-8a0f-4e8a-ab02-df6ebe03e4ef";    //take id from shared preferences
  Future<UserProfile?> getUserDetails() async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTc4NDg1MCwiZXhwIjoxNjU1ODcxMjUwfQ.OmUQ4Iljk0_Ok1xoO68C--6dPKrDc4G1tlpAcpJaVso'
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

  Future<UpdateProfile?> updateUserDetails({
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
        ApiUtils.authorization : 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTc4NDg1MCwiZXhwIjoxNjU1ODcxMjUwfQ.OmUQ4Iljk0_Ok1xoO68C--6dPKrDc4G1tlpAcpJaVso'
      };
      http.Response response=await http.put(Uri.parse(getUserUrl),headers:header,body: body);

      if(response.statusCode==200){
        return UpdateProfile.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
      return UpdateProfile();
    }
  }


  static const categoryUrl=ApiUtils.baseUrl+ApiUtils.category;
  Future<ViewCategory?> viewCategories()async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTc4NDc1NiwiZXhwIjoxNjU1ODcxMTU2fQ.WltUbVOFK9gYJG1xUl2otGKYGQfu9nqw99EqIhbalBU'
      };
      final response = await http.get(Uri.parse(categoryUrl),headers: header);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String,dynamic> mapResponse = json.decode(response.body);
        return ViewCategory.fromJson(mapResponse);
        // Data dataModel = Data.fromJson(mapResponse);
        // return dataModel;
      }
    }catch(e){
      print(e.toString());
      return ViewCategory();
    }
  }
}