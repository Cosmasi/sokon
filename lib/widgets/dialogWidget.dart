import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokon/models/cartItems.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/models/vendors.dart';
import 'package:sokon/providers/ordersProvider.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:sokon/tools/app_tools.dart';
import 'package:sokon/widgets/progressDialog.dart';


class DialogWidget extends StatefulWidget {
  final OrderItems order;

  DialogWidget({this.order});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final List<TextEditingController> priceEditingController = [];

  List<CartItems> priceList = [];

  String price;
  String getTitle;
  String getId;
  String vName;
  String vNo;
  final dateTime = DateTime.now();
  int i;

  Vendors _vendors;

  User user = FirebaseAuth.instance.currentUser;
  DatabaseReference vendorsRef = FirebaseDatabase.instance.reference().child("vendors");
  DatabaseReference orderRef = FirebaseDatabase.instance.reference().child(orderNode);
  DatabaseReference resendRef = FirebaseDatabase.instance.reference().child("resendOrders");


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("MY LIST:: ${widget.order.products.map((e) => e.title).toList()}");
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          // backgroundColor: Colors.transparent,
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7)
                            )
                          ]
                      ),
                      child: Image.asset('assets/images/user_icon.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.order.username}", style: TextStyle(fontSize: 20.0)),
                          SizedBox(height: 5.0),
                          Text("${widget.order.phoneNumber}", style: TextStyle(fontSize: 20.0)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0,),
              Text('NEW ORDER REQUEST', style: TextStyle(fontSize: 18),),
              Divider(thickness: 1.0,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: widget.order.products.length,
                    itemBuilder: (_, index){
                      i = index;
                      priceEditingController.add(TextEditingController());
                      priceEditingController[index].text = widget.order.products[index].price;
                      // getTitle = widget.order.products[index].title;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("${widget.order.products[index].title}", style: TextStyle(fontSize: 20.0),),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                    child: textField(
                                      controller: priceEditingController[index],
                                      onChanged: (newPrice){
                                        price = newPrice;
                                      }
                                    ),
                                  )
                              )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        Navigator.pop(context);
                        assetsAudioPlayer.stop();
                        resendOrder(priceList);
                        // updatePrice(priceList);
                      },
                      child: Container(
                          width: 100.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Center(
                            child: Text("RE-SEND", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          )
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        addPrice();
                        assetsAudioPlayer.stop();
                      },
                      child: Container(
                          width: 70.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Center(
                            child: Text("ADD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          )
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        assetsAudioPlayer.stop();
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 100.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Center(
                            child: Text("DECLINE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget textField({
    Function onSubmit,
    Function onChanged,
    String textHint,
    TextEditingController controller
  }){

    List<TextField> field = [];

    field.add(TextField(
      controller: controller,
      onSubmitted: onSubmit,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: textHint,
      ),
    ));
    return Column(children: field);
  }



  void addPrice(){
    priceList.add(CartItems(
      price: price,
    ));
    print(priceList);
  }


  // Future<String> updatePrice(List<CartItems> cartProducts) async{
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => ProgressDialog(status: "Please wait...",),
  //   );
  //
  //   orderRef.child(widget.order.user_id).child(widget.order.id).update({
  //     "products": cartProducts.map((e) => {
  //       "id": "",
  //       "title": e.title.toString(),
  //       "quantity": "",
  //       "price": e.price.toString(),
  //       "selectedQty": ""
  //     }).toList()
  //   }).whenComplete(() => Navigator.pop(context));
  //   resendOrder(cartProducts);
  //   return "successfully";
  // }

  Future<String> resendOrder(List<CartItems> cartProducts) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProgressDialog(status: "Please wait...",),
    );
    resendRef.child(widget.order.user_id).child(user.uid).push().set({
      "products": cartProducts.map((e) => {
        "id": "",
        "title": e.title.toString(),
        "quantity": "",
        "price": e.price.toString(),
        "selectedQty": ""
      }).toList(),
      "dateTime": dateTime.toIso8601String(),
      "userName": vendorsInfo.vendorName,
      "phone": vendorsInfo.vendorPhone,
      "vendor_id": user.uid
    }).whenComplete(() => Navigator.pop(context));

    return "successfully";
  }
}