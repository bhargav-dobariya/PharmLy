import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pharmly/models/add_new_address_model.dart';
import 'package:pharmly/models/add_order_model.dart';

import 'package:pharmly/models/all_desease_model.dart';
import 'package:pharmly/models/disease_product.dart';
import 'package:pharmly/models/delete_user_model.dart';
import 'package:pharmly/models/forgot_password_model.dart';
import 'package:pharmly/models/login_model.dart';
import 'package:pharmly/models/otp_resend_model.dart';
import 'package:pharmly/models/otp_verification_model.dart';
import 'package:pharmly/models/signup_model.dart';
import 'package:pharmly/methods/shared_prefs_methods.dart';
import 'package:pharmly/models/add_product_to_cart.dart';
import 'package:pharmly/models/delete_from_cart_model.dart';
import 'package:pharmly/models/get_addresses_model.dart';
import 'package:pharmly/models/get_cart_model.dart';
import 'package:pharmly/models/logout_user_model.dart';
import 'package:pharmly/models/product_model.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/api_utils.dart';
import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/models/update_user_profile.dart';
import 'package:pharmly/models/view_category.dart';

class ApiService {
  var userToken = 'Bearer ' + PreferenceHelper.getAccessToken();
  //user registration url
  static const String _userRegistrationurl = ApiUtils.baseUrl + ApiUtils.users;
  static const String _userLoginUrl = ApiUtils.baseUrl + ApiUtils.login;
  static const String _allDisease = ApiUtils.baseUrl +
      ApiUtils.all_disease +
      "a19b6c7e-5006-41d4-9d9f-8ac82a4a6175/";
  static const String _verifyUserUrl = ApiUtils.baseUrl + ApiUtils.verify;
  static const String _resendOtpUrl = ApiUtils.baseUrl + ApiUtils.resend;
  static const String _addAddressUrl = ApiUtils.baseUrl + ApiUtils.addAddress;

  static const String _forgotPassword =
      ApiUtils.baseUrl + ApiUtils.forgotPassword;
  static const categoryUrl = ApiUtils.baseUrl + ApiUtils.category;
  static const String getUserUrl = ApiUtils.baseUrl +
      ApiUtils.users; //take id from shared preferences
  var userId=PreferenceHelper.getUserAccessId();

  var userId = PreferenceHelper.getUserAccessId();
  //user registration url
  static const String allDisease = ApiUtils.baseUrl + ApiUtils.allDisease;
  static const logOutUrl=ApiUtils.baseUrl+ApiUtils.logout;
  static const getProductUrl=ApiUtils.baseUrl + ApiUtils.allProduct;
  static const getAddressesUrl=ApiUtils.baseUrl + ApiUtils.addresses;
  static const cartUrl=ApiUtils.baseUrl + ApiUtils.cart;
  static const addOrderUrl=ApiUtils.baseUrl + ApiUtils.placedorder;
  static const deleteUserUrl=ApiUtils.baseUrl + ApiUtils.users;

  static const logOutUrl = ApiUtils.baseUrl + ApiUtils.logout;
  static const getProductUrl = ApiUtils.baseUrl + ApiUtils.allProduct;
  static const getAddressesUrl = ApiUtils.baseUrl + ApiUtils.addresses;
  static const cartUrl = ApiUtils.baseUrl + ApiUtils.cart;
  static const productDiseaseUrl = ApiUtils.baseUrl + ApiUtils.diseaseProduct;

  //user registration url
  Future<SignUpModel> userRegistration(
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
    try {
      http.Response response =
          await http.post(Uri.parse(_userRegistrationurl), body: body);
      print(response.body);
      print(response.statusCode);

      Map<String, dynamic> mapResponse = json.decode(response.body);
      return SignUpModel.fromJson(mapResponse);
    } catch (e) {
      return SignUpModel();
    }
  }

//login api

  Future<LoginModel?> userLogin({String? email, String? password}) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
      ApiUtils.password: password,
    };
    try {
      http.Response response =
          await http.post(Uri.parse(_userLoginUrl), body: body);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      print("Login APi Res:${response.statusCode}");
      // if (response.statusCode == 406) {
      //   Fluttertoast.showToast(
      //       msg: "You entered wrong password,Please try to add right password");
      // }
      return LoginModel.fromJson(mapResponse);
    } catch (e) {
      return LoginModel();
    }
  }

//disease api
  Future<DiseaseModel> getAllDisease() async {
    Map<String, String> header = {ApiUtils.authorization: userToken};
    try {
      http.Response response = await http.get(
        Uri.parse(allDisease + 'a19b6c7e-5006-41d4-9d9f-8ac82a4a6175'),
        headers: header,
      );
      Map<String, dynamic> mapResponse = json.decode(response.body);
      print(response.body);

      return DiseaseModel.fromJson(mapResponse);
    } catch (e) {
      return DiseaseModel();
    }
  }

//verify user

  Future<OtpVerificationModel> verifyEmail(String? email, String? otp) async {
    Map<String, dynamic> body = {ApiUtils.email: email, ApiUtils.otp: otp};
    try {
      http.Response response =
          await http.post(Uri.parse(_verifyUserUrl), body: body);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      return OtpVerificationModel.fromJson(mapResponse);
    } catch (e) {
      return OtpVerificationModel();
    }
  }

//otp resend
  Future<OtpResendModel> otpResend(String? email) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
    };
    try {
      http.Response response =
          await http.post(Uri.parse(_resendOtpUrl), body: body);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      return OtpResendModel.fromJson(mapResponse);
    } catch (e) {
      return OtpResendModel();
    }
  }

  //forgotpassword
  Future<ForgotPasswordModel> addPassword(
      String? email, String? password) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
      ApiUtils.newPassword: password
    };
    try {
      http.Response response =
          await http.post(Uri.parse(_forgotPassword), body: body);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      print(response.statusCode);
      print(response.body);
      return ForgotPasswordModel.fromJson(mapResponse);
    } catch (e) {
      return ForgotPasswordModel();
    }
  }
//add New Adress Api

  Future<AddNewAdressModel?> addNewAddress({
    String? addresss,
    String? area,
    String? city,
    String? pincode,
  }) async {
    Map<String, dynamic> body = {
      ApiUtils.address: addresss,
      ApiUtils.area: area,
      ApiUtils.city: city,
      ApiUtils.pinCode: pincode,
    };
    try {
      Map<String, String> header = {ApiUtils.authorization: userToken};

      http.Response response = await http.post(
        Uri.parse(_addAddressUrl),
        body: body,
        headers: header,
      );
      Map<String, dynamic> mapResponse = json.decode(response.body);
      return AddNewAdressModel.fromJson(mapResponse);
    } catch (e) {
      return AddNewAdressModel();
    }
  }

//get Disease product
  Future<DiseaseProduct?> getDiseaseProduct({String? categoryId}) async {
    try {
      Map<String, String> header = {ApiUtils.authorization: userToken};
      http.Response response = await http.get(
        Uri.parse(getProductUrl + categoryId!),
        headers: header,
      );
      print("Product details:${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        return DiseaseProduct.fromJson(mapResponse);
      }
    } catch (e) {
      print(e.toString());
      return DiseaseProduct();
    }
    return null;
  }

//get userDetails api
  Future<UserProfile?> getUserDetails() async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : userToken
      };
      final response = await http.get(Uri.parse(getUserUrl + userId),headers: header);
      print("User details:${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String,dynamic> mapResponse = json.decode(response.body);
        return UserProfile.fromJson(mapResponse);
      }
    }
    catch(e){
      // print(e.toString());
      return UserProfile();
    }
  }

//update user api
  Future<UpdateProfile?> updateUserDetails({
    String? firstName,
    String? lastName,
    String? contactNo,
  }) async {
    Map<String, dynamic> body = {
      ApiUtils.firstName: firstName,
      ApiUtils.lastName: lastName,
      ApiUtils.contactNo: contactNo,
    };

    try{
      Map<String,String> header = {
        ApiUtils.authorization : userToken
      };
      http.Response response=await http.put(Uri.parse(getUserUrl + userId),headers:header,body: body);
      print("Update details:${response.statusCode}");
      if(response.statusCode==200){
        Fluttertoast.showToast(msg: AppString.txtUpdatedDetails);
        return UpdateProfile.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
      return UpdateProfile();
    }
    return null;
  }


  Future<DeleteUserModel?> deleteUser()async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : userToken
      };
      http.Response response=await http.delete(Uri.parse(deleteUserUrl + userId),headers: header);
      print("Delete user: ${response.statusCode}");
      if(response.statusCode==200){
        return DeleteUserModel.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
      return DeleteUserModel();
    }
  }


  Future<ViewCategory?> viewCategories()async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : userToken
      };
      final response = await http.get(Uri.parse(categoryUrl),headers: header);
      print(userToken);
      print("View categories:${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        return ViewCategory.fromJson(mapResponse);
        // Data dataModel = Data.fromJson(mapResponse);
        // return dataModel;
      }
    } catch (e) {
      print(e.toString());
      return ViewCategory();
    }
    return null;
  }

  Future<LogOutUser?> logOutUser({String? email})async{
    try{
      Map<String,String> header = {
        ApiUtils.authorization : userToken
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
        ApiUtils.authorization : userToken
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
        ApiUtils.authorization : userToken
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
        ApiUtils.authorization : userToken
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
        ApiUtils.authorization : userToken
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
        ApiUtils.authorization : userToken
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


  Future<AddOrderModel?> addOrder({String? cartId,String? addressId})async{
    try{
      Map<String,String> header={
        ApiUtils.authorization : userToken
      };
      Map<String,dynamic> body={
        ApiUtils.cartId: cartId,
        ApiUtils.addressId: addressId
      };
      http.Response response=await http.post(Uri.parse(addOrderUrl),headers:header,body: body);
      print("Place cart:: ${response.statusCode}");
      if(response.statusCode==200){
        return AddOrderModel.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
      return AddOrderModel();
    }
  }

}
  