import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_string.dart';

class PreferenceHelper {
  static late SharedPreferences prefs;

  static initPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setAccessToken(accessToken) {
    prefs.setString(AppString.userToken, accessToken);
  }

  static setUserId(userId) {
    prefs.setString(AppString.userId, userId);
  }

  static setLastName(lastname) {
    prefs.setString(AppString.txtLastName, lastname);
  }

  static setFirstName(firstname) {
    prefs.setString(AppString.txtFirstName, firstname);
  }

  static setPhoneNumber(phoneNumber) {
    prefs.setString(AppString.txtPhoneNumber, phoneNumber);
  }

  static setPassword(password) {
    prefs.setString(AppString.txtPassword, password);
  }

  static setEmail(email) {
    prefs.setString(AppString.txtEmailAddress, email);
  }

  static getLastName() {
    return prefs.getString(AppString.txtLastName);
  }

  static getFirstName() {
    return prefs.getString(AppString.txtFirstName);
  }

  static getPhoneNumber() {
    return prefs.getString(AppString.txtPhoneNumber);
  }

  static getPassword() {
    return prefs.getString(AppString.txtPassword);
  }

  static getEmail() {
    return prefs.getString(AppString.txtEmailAddress);
  }

  static getAccessToken() {
    return prefs.getString(AppString.userToken);
  }

  static getUserId() {
    prefs.getString(AppString.userId);
  }
}
