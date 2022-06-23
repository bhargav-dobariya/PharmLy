import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_string.dart';

class ConstantMethod {
  static late SharedPreferences prefs;
  static getUserAccessToken() {
    return prefs.getString(AppString.userToken);
  }

  static getUserAccessId(){
    return prefs.getString(AppString.userId);
  }

  static keepUserLoggedIn(){
    return prefs.getBool(AppString.txtIsLoggedIn);
  }

  static Future initPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

}