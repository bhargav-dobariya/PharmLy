import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pharmly/models/add_product_to_cart.dart';

import 'package:pharmly/models/all_desease_model.dart';
import 'package:pharmly/models/delete_from_cart_model.dart';
import 'package:pharmly/models/get_addresses_model.dart';
import 'package:pharmly/models/get_cart_model.dart';
import 'package:pharmly/models/login_model.dart';
import 'package:pharmly/models/logout_user_model.dart';
import 'package:pharmly/models/product_model.dart';
import 'package:pharmly/models/signup_model.dart';
import 'package:pharmly/networking/preference_helper.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/api_utils.dart';
import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/models/update_user_profile.dart';
import 'package:pharmly/models/view_category.dart';



class ApiService {
  var userToken = PreferenceHelper.getUserAccessToken();
  var userId=PreferenceHelper.getUserAccessId();
  //user registration url
  static const String _userRegistrationurl = ApiUtils.baseUrl + ApiUtils.users;
  static const String _userLoginUrl = ApiUtils.baseUrl + ApiUtils.login;
  static const String allDisease = ApiUtils.baseUrl + ApiUtils.allDisease;
  static const String getUserUrl = ApiUtils.baseUrl + ApiUtils.users;    //take id from shared preferences
  static const categoryUrl=ApiUtils.baseUrl+ApiUtils.category;
  static const logOutUrl=ApiUtils.baseUrl+ApiUtils.logout;
  static const getProductUrl=ApiUtils.baseUrl + ApiUtils.allProduct;
  static const getAddressesUrl=ApiUtils.baseUrl + ApiUtils.addresses;
  static const cartUrl=ApiUtils.baseUrl + ApiUtils.cart;


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
  Future<DiseaseModel> getAllDisease() async {
    Map<String, String> header = {ApiUtils.authorization: userToken};
    http.Response response = await http.get(
      Uri.parse(allDisease + 'a19b6c7e-5006-41d4-9d9f-8ac82a4a6175'),
      headers: header,
    );
    Map<String, dynamic> mapResponse = json.decode(response.body);

    return DiseaseModel.fromJson(mapResponse);
  }



  Future<UserProfile?> getUserDetails() async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      final response = await http.get(Uri.parse(getUserUrl + userId),headers: header);
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
      http.Response response=await http.put(Uri.parse(getUserUrl + userId),headers:header,body: body);
      print("Update details:${response.statusCode}");
      if(response.statusCode==200){
        Fluttertoast.showToast(msg: AppString.txtUpdatedDetails);
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
      print("Log out:${response.statusCode}");
      if(response.statusCode==200){
        Map<String, dynamic> mapResponse = json.decode(response.body);
        Fluttertoast.showToast(msg: AppString.txtSignedOut);
        return LogOutUser.fromJson(mapResponse);
      }
    }catch(e) {
      print(e.toString());
      return LogOutUser();
    }
  }


  Future<ProductModel?> getProductDetails({String? categoryId})async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      http.Response response=await http.get(Uri.parse(getProductUrl + categoryId!),headers: header,);
      print("Product details:${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String,dynamic> mapResponse = json.decode(response.body);
        return ProductModel.fromJson(mapResponse);
      }
    }catch(e){
      print(e.toString());
      return ProductModel();
    }
  }


  Future<GetAddressesModel?> getAddresses()async{
    try{
      Map<String,String> header={
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      final http.Response response=await http.get(Uri.parse(getAddressesUrl),headers: header);
      print("Addresses: ${response.statusCode}");
      if(response.statusCode==200){
        Map<String,dynamic> mapResponse = json.decode(response.body);
        return GetAddressesModel.fromJson(mapResponse);
      }
    }catch(e){
      print(e.toString());
      GetAddressesModel();
    }
  }


  Future<AddProductToCartModel?> postProductToCart({String? productId})async{
    try{
      Map<String,String> header={
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      Map<String,dynamic> body={
        ApiUtils.productId: productId,
      };
      http.Response response=await http.post(Uri.parse(cartUrl + productId!),headers:header,body: body);
      print("Add to cart: ${response.statusCode}");
      if(response.statusCode==200){
        return AddProductToCartModel.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
      return AddProductToCartModel();
    }
  }


  Future<GetCartModel?> getCart()async{
    try{
      Map<String,String> header={
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      http.Response response=await http.get(Uri.parse(cartUrl),headers: header);
      print("Get cart: ${response.statusCode}");
      if(response.statusCode==200){
        Map<String,dynamic> mapResponse = json.decode(response.body);
        return GetCartModel.fromJson(mapResponse);
      }
    }catch(e){
      print(e.toString());
      return GetCartModel();
    }
  }


  Future<DeleteFromCartModel?> deleteItem({String? productId})async{
    try{
      Map<String,String> header={
        ApiUtils.authorization : 'Bearer ' + userToken
      };
      Map<String,dynamic> body={
        ApiUtils.productId: productId,
      };
      http.Response response=await http.delete(Uri.parse(cartUrl + productId!),headers:header,body: body);
      print("Delete from cart: ${response.statusCode}");
      if(response.statusCode==200){
        return DeleteFromCartModel.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
      return DeleteFromCartModel();
    }
  }
}