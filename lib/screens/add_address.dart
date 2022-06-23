import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/utils/validator.dart';
import '../methods/check_internet_connectivity.dart.dart';
import '../networking/api_service.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}
// address: '13, andheri',
//         area: 'andheri area',
//         city: 'mumbai',
//         pincode: '310310',

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  bool _isLoading = false;

  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.lightBlueColor,
          title: Text(AppString.txtAddDeliveryAddress),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              bgUi(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: _deviceHeight * 0.18),
                        height: _deviceHeight * 0.15,
                        width: MediaQuery.of(context).size.height / 1.22,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.blueColor),
                            color: AppColor.whitecolor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.colorSkipforNow,
                                blurRadius: 25,
                              )
                            ]),
                        child: TextFormField(
                          controller: _addressController,
                          style: TextStyle(fontSize: _deviceHeight * 0.022),

                          maxLines: 5,
                          // controller: ,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(13),
                            hintText: AppString.txtAddress,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.colorHintText),
                          ),
                        ),
                      ),
                      Container(
                        height: _deviceHeight * 0.09,
                        margin: EdgeInsets.only(top: _deviceHeight * 0.02),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.blueColor),
                            color: AppColor.whitecolor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.colorSkipforNow,
                                blurRadius: 25,
                              )
                            ]),
                        child: TextFormField(
                          validator: Validator.adreesField,
                          controller: _areaController,
                          style: TextStyle(fontSize: _deviceHeight * 0.022),
                          maxLines: 2,
                          // controller: ,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(19),
                            hintText: AppString.txtArea,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.colorHintText),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: _deviceHeight * 0.07,
                            width: _deviceWidth * 0.4,
                            margin: EdgeInsets.only(top: _deviceHeight * 0.02),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.blueColor),
                                color: AppColor.whitecolor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.colorSkipforNow,
                                    blurRadius: 25,
                                  )
                                ]),
                            child: TextFormField(
                              validator: Validator.adreesField,

                              controller: _cityController,
                              style: TextStyle(fontSize: _deviceHeight * 0.022),
                              maxLines: 1,
                              // controller: ,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: AppString.txtCity,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.colorHintText),
                              ),
                            ),
                          ),
                          Container(
                            height: _deviceHeight * 0.07,
                            width: _deviceWidth * 0.4,
                            margin: EdgeInsets.only(
                                top: _deviceHeight * 0.02,
                                left: _deviceWidth * 0.14),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.blueColor),
                                color: AppColor.whitecolor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.colorSkipforNow,
                                    blurRadius: 25,
                                  )
                                ]),
                            child: TextFormField(
                              validator: Validator.pinCode,
                              controller: _pincodeController,
                              style: TextStyle(fontSize: _deviceHeight * 0.022),
                              maxLines: 2,
                              // controller: ,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: AppString.txtPinCode,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.colorHintText),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //submit button
                      GestureDetector(
                        onTap: () async {
                          final result =
                              await Connectivity().checkConnectivity();
                          showConnectivityToast(result);
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            ApiService()
                                .addNewAddress(
                                    addresss: _addressController.text,
                                    area: _areaController.text,
                                    city: _cityController.text,
                                    pincode: _pincodeController.text)
                                .then(
                              (res) async {
                                if (res.code == 200) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.pushNamed(
                                      context, '/disease_screenScreen');
                                }
                              },
                            );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: _deviceWidth * 0.46,
                              top: _deviceHeight * 0.08),
                          width: _deviceWidth * 0.46,
                          height: _deviceHeight * 0.062,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.lightBlueColor2,
                                  AppColor.lightBlueColor,
                                ],
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          alignment: Alignment.center,
                          child: Text(
                            AppString.txtSubmit,
                            style: TextStyle(
                              fontSize: 19,
                              color: AppColor.whitecolor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget bgUi() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: const BoxDecoration(
        // background color
        image: DecorationImage(
            image: AssetImage(
              "assets/images/bg_image.png",
            ),
            fit: BoxFit.cover), // background image above color
      ),
    );
  }
}
