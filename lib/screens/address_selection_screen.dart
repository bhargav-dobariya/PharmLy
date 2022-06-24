import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmly/models/get_addresses_model.dart';
import 'package:pharmly/networking/api_service.dart';
import 'package:pharmly/resources/app_color.dart';
import 'package:pharmly/resources/app_string.dart';
import 'package:pharmly/screens/home_screen.dart';
import 'package:pharmly/widgets/bottom_nav_bar.dart';

class AddressSelectionScreen extends StatefulWidget {
  final String cartId;
  final String billTotal;
  const AddressSelectionScreen({Key? key,required this.cartId,required this.billTotal}) : super(key: key);

  @override
  _AddressSelectionScreenState createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  late Future<GetAddressesModel?> getAddress;

  getAddressDetails(){
    getAddress=ApiService().getAddresses();
  }

  @override
  void initState() {
    getAddressDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("In the screen?");
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.colorBlack12.withAlpha(20),
        appBar: AppBar(
          title: Text(AppString.txtSelectAddress,style: TextStyle(color: AppColor.colorWhite,fontSize: 17),),
          centerTitle: true,
          backgroundColor: AppColor.colorTheme,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<GetAddressesModel?>(
                  future: getAddress,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return Container(
                        color: AppColor.lightgreyColor,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (ctx,index){
                            return GestureDetector(
                              onTap: ()async{
                                print(snapshot.data!.data![index].id);
                                return await showDialog(
                                  context: context,
                                  builder: (context)=>AlertDialog(
                                    title: Text(AppString.txtOrderConfirmation),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text("${AppString.txtOrderConfirmationBody}. If yes, then proceed to payment gateway for the payment of  Rs. ${widget.billTotal}")
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: (){
                                            ApiService().addOrder(cartId: widget.cartId,addressId: snapshot.data!.data![index].id).then((value){
                                              if(value?.code!=200){
                                                Fluttertoast.showToast(msg: AppString.txtSomeErrorOccurred);
                                              }
                                              else{
                                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavBar()),(Route<dynamic> route) => false);
                                                Fluttertoast.showToast(msg: AppString.txtOrderPlacedSuccessfully);
                                              }
                                            });
                                          },
                                          child: Text(AppString.txtConfirm,style: TextStyle(color: AppColor.colorRed),)
                                      )
                                    ],
                                  )
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/6,
                                margin: EdgeInsets.only(bottom: 10,top: 10),
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/26.13),
                                child: Text("${snapshot.data!.data![index].address!}, ${snapshot.data!.data![index].area!}, ${snapshot.data!.data![index].city!}, ${snapshot.data!.data![index].pincode!}",style: TextStyle(fontSize: 15,color: AppColor.colorBlack,),maxLines: 5,),
                                decoration: BoxDecoration(
                                    color: AppColor.colorWhite,
                                    boxShadow: [
                                      BoxShadow(color: AppColor.colorBlack12,blurRadius: 2,spreadRadius: 2)
                                    ]
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
