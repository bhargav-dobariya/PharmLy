import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_string.dart';

class ConstantMethod {
  static getUserAccessToken() {
    SharedPreferences.getInstance().then((sharedPref) async {
      var _prefs = sharedPref;

      var userToken = _prefs.getString(AppString.userToken);
      return userToken;
    });
  }
}
