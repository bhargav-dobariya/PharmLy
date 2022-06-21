import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';

void showConnectivityToast(ConnectivityResult result){
  if(result == ConnectivityResult.none){
    Fluttertoast.showToast(
      msg: AppString.txtCheckYourInternetConnection,
      textColor: AppColor.colorWhite,
      backgroundColor: AppColor.colorRedAccent,
    );
  }
  else{
    print(result.toString());
  }
}