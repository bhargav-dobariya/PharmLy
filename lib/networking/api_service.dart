import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmly/models/add_new_address_model.dart';

import 'package:pharmly/models/all_desease_model.dart';
import 'package:pharmly/models/forgot_password_model.dart';
import 'package:pharmly/models/login_model.dart';
import 'package:pharmly/models/otp_resend_model.dart';
import 'package:pharmly/models/otp_verification_model.dart';
import 'package:pharmly/models/signup_model.dart';
import 'package:pharmly/methods/shared_prefs_methods.dart';
import 'package:pharmly/utils/api_utils.dart';
import 'package:pharmly/models/get_user_model.dart';
import 'package:pharmly/models/update_user_profile.dart';
import 'package:pharmly/models/view_category.dart';

class ApiService {
  var userToken = 'Bearer ' + ConstantMethod.getAccessToken();
  //user registration url
  static const String _userRegistrationurl = ApiUtils.baseUrl + ApiUtils.users;
  static const String _userLoginUrl = ApiUtils.baseUrl + ApiUtils.login;
  static const String _allDisease = ApiUtils.baseUrl + ApiUtils.all_disease;
  static const String _verifyUserUrl = ApiUtils.baseUrl + ApiUtils.verify;
  static const String _resendOtpUrl = ApiUtils.baseUrl + ApiUtils.resend;
  static const String _addAddressUrl = ApiUtils.baseUrl + ApiUtils.addAddress;

  static const String _forgotPassword =
      ApiUtils.baseUrl + ApiUtils.forgotPassword;

  static const String getUserUrl = ApiUtils.baseUrl +
      ApiUtils.users +
      "89994fcc-8a0f-4e8a-ab02-df6ebe03e4ef"; //take id from shared preferences
  static const categoryUrl = ApiUtils.baseUrl + ApiUtils.category;

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

    http.Response response =
        await http.post(Uri.parse(_userRegistrationurl), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return SignUpModel.fromJson(mapResponse);
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
    print(mapResponse);
    return LoginModel.fromJson(mapResponse);
  }

//disease api
  Future<DiseaseModel> getAllDisease() async {
    Map<String, String> header = {ApiUtils.authorization: userToken};
    http.Response response = await http.get(
      Uri.parse(_allDisease),
      headers: header,
    );
    Map<String, dynamic> mapResponse = json.decode(response.body);
    print(response.body);

    return DiseaseModel.fromJson(mapResponse);
  }

//verify user

  Future<OtpVerificationModel> verifyEmail(String? email, String? otp) async {
    Map<String, dynamic> body = {ApiUtils.email: email, ApiUtils.otp: otp};

    http.Response response =
        await http.post(Uri.parse(_verifyUserUrl), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return OtpVerificationModel.fromJson(mapResponse);
  }

//otp resend
  Future<OtpResendModel> otpResend(String? email) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
    };

    http.Response response =
        await http.post(Uri.parse(_resendOtpUrl), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return OtpResendModel.fromJson(mapResponse);
  }

  //forgotpassword
  Future<ForgotPasswordModel> addPassword(
      String? email, String? password) async {
    Map<String, dynamic> body = {
      ApiUtils.email: email,
      ApiUtils.password: password
    };

    http.Response response =
        await http.post(Uri.parse(_forgotPassword), body: body);
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return ForgotPasswordModel.fromJson(mapResponse);
  }
//add New Adress Api

  Future<AddNewAdressModel> addNewAddress({
    String? addresss,
    String? area,
    String? city,
    String? pincode,
  }) async {
    Map<String, dynamic> body = {
      ApiUtils.address: addresss,
      ApiUtils.area: area,
      ApiUtils.pinCode: city,
      ApiUtils.city: pincode,
    };
    Map<String, String> header = {ApiUtils.authorization: userToken};

    http.Response response = await http.post(
      Uri.parse(_addAddressUrl),
      body: body,
      headers: header,
    );
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return AddNewAdressModel.fromJson(mapResponse);
  }

//get userDetails api
  Future<UserProfile?> getUserDetails() async {
    try {
      Map<String, String> header = {
        ApiUtils.authorization:
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTc4NDg1MCwiZXhwIjoxNjU1ODcxMjUwfQ.OmUQ4Iljk0_Ok1xoO68C--6dPKrDc4G1tlpAcpJaVso'
      };
      final response = await http.get(Uri.parse(getUserUrl), headers: header);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        return UserProfile.fromJson(mapResponse);
      }
    } catch (e) {
      return UserProfile();
    }
    return null;
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

    try {
      Map<String, String> header = {
        ApiUtils.authorization:
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTc4NDg1MCwiZXhwIjoxNjU1ODcxMjUwfQ.OmUQ4Iljk0_Ok1xoO68C--6dPKrDc4G1tlpAcpJaVso'
      };
      http.Response response =
          await http.put(Uri.parse(getUserUrl), headers: header, body: body);

      if (response.statusCode == 200) {
        return UpdateProfile.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
      return UpdateProfile();
    }
    return null;
  }

//category api
  Future<ViewCategory?> viewCategories() async {
    try {
      Map<String, String> header = {
        ApiUtils.authorization:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg5OTk0ZmNjLThhMGYtNGU4YS1hYjAyLWRmNmViZTAzZTRlZiIsImVtYWlsIjoiYXBleGEzcGF0ZWxAZ21haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsImlhdCI6MTY1NTc4NDc1NiwiZXhwIjoxNjU1ODcxMTU2fQ.WltUbVOFK9gYJG1xUl2otGKYGQfu9nqw99EqIhbalBU'
      };
      final response = await http.get(Uri.parse(categoryUrl), headers: header);
      print(response.statusCode);
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
}
