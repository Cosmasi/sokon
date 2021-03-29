import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';


class DialogWidget extends StatelessWidget {
  final OrderItems order;

  DialogWidget({this.order});

  final List<TextEditingController> priceEditingController = [];

  final User user = FirebaseAuth.instance.currentUser;

  final DatabaseReference userRef = FirebaseDatabase.instance.reference().child("fullName");

  Widget textField({
    Function onSubmit,
    String textHint,
    TextEditingController controller
  }){

    List<TextField> field = [];

    field.add(TextField(
      controller: controller,
      onSubmitted: onSubmit,
      decoration: InputDecoration(
        hintText: textHint,
      ),
    ));
    return Column(children: field);
  }

  @override
  Widget build(BuildContext context) {
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
                          Text("${order.username}", style: TextStyle(fontSize: 20.0)),
                          SizedBox(height: 5.0),
                          Text("${order.phoneNumber}", style: TextStyle(fontSize: 20.0)),
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
                    itemCount: order.products.length,
                    itemBuilder: (_, index){
                      priceEditingController.add(TextEditingController());
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("${order.products[index].title}", style: TextStyle(fontSize: 20.0),),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                    child: textField(
                                      controller: priceEditingController[index],
                                      textHint: "0.0",
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
                      onTap: (){
                        assetsAudioPlayer.stop();
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
}