import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pharmly/models/all_desease_model.dart';
import 'package:pharmly/models/login_model.dart';
import 'package:pharmly/models/logout_user_model.dart';
import 'package:pharmly/models/signup_model.dart';
import 'package:pharmly/networking/const_method.dart';
import 'package:pharmly/utils/api_utils.dart';
import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/models/update_user_profile.dart';
import 'package:pharmly/models/view_category.dart';



class ApiService {
  var userToken = ConstantMethod.getUserAccessToken();
  //user registration url
  static const String _userRegistrationurl = ApiUtils.baseUrl + ApiUtils.users;
  static const String _userLoginUrl = ApiUtils.baseUrl + ApiUtils.login;
  static const String _allDisease = ApiUtils.baseUrl + ApiUtils.users;
  static const String getUserUrl = ApiUtils.baseUrl + ApiUtils.users + "89994fcc-8a0f-4e8a-ab02-df6ebe03e4ef";    //take id from shared preferences
  static const categoryUrl=ApiUtils.baseUrl+ApiUtils.category;
  static const logOutUrl=ApiUtils.baseUrl+ApiUtils.logout;



  //user registration url
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

  Future<LoginModel> userLogin({String? email, String? password}) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
      ApiUtils.password: password,
    };
    http.Response response =
        await http.post(Uri.parse(_userLoginUrl), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    print("Login:${response.statusCode}");
    return LoginModel.fromJson(mapResponse);
  }

//disease api
  Future<diseaseModel> getAllDisease() async {
    Map<String, String> header = {ApiUtils.authorization: userToken};
    http.Response response = await http.get(
      Uri.parse(_allDisease),
      headers: header,
    );
    Map<String, dynamic> mapResponse = json.decode(response.body);

    return diseaseModel.fromJson(mapResponse);
  }



  Future<UserProfile?> getUserDetails() async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      final response = await http.get(Uri.parse(getUserUrl),headers: header);
      print("User details:${response.statusCode}");
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
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      http.Response response=await http.put(Uri.parse(getUserUrl),headers:header,body: body);
      print("Update details:${response.statusCode}");
      if(response.statusCode==200){
        return UpdateProfile.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
      return UpdateProfile();
    }
  }


  Future<ViewCategory?> viewCategories()async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      final response = await http.get(Uri.parse(categoryUrl),headers: header);
      print(userToken);
      print("View categories:${response.statusCode}");
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

  Future<LogOutUser?> logOutUser({String? email})async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      Map<String, dynamic> body = {
        ApiUtils.email: email,
      };
      http.Response response=await http.post(Uri.parse(logOutUrl),body: body,headers: header);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      print("Log out:${response.statusCode}");
      return LogOutUser.fromJson(mapResponse);
    }catch(e) {
      print(e.toString());
      return LogOutUser();
    }
  }
}