import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';

class NotificationDialog extends StatefulWidget {

  final List<OrderItems> orderItem;

  NotificationDialog({this.orderItem});

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  TextEditingController _priceController = TextEditingController();

  String _userId;
  String userName;
  String phone;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  void getUserInfo(){
    for(int i = 0; i<widget.orderItem.length; i++){
      _userId = widget.orderItem[i].user_id;
      userName = widget.orderItem[i].username;
      phone = widget.orderItem[i].phoneNumber;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      // insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$userName", style: TextStyle(fontSize: 20.0)),
                        SizedBox(height: 5.0,),
                        Text("$phone", style: TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Text('NEW ORDER REQUEST', style: TextStyle(fontSize: 18),),
            Divider(thickness: 1.0,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.orderItem.length,
                  itemBuilder: (_, index) => Column(
                    children: widget.orderItem[index].products.map((e){
                      return Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.title, style: TextStyle(fontSize: 20.0))
                                ],
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Container(
                              width: 80.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.grey[200]
                              ),
                              child: TextField(
                                // controller: _priceController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0.0",
                                  contentPadding: EdgeInsets.symmetric(vertical: 8.5, horizontal: 7.0)
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }).toList()
                  ),
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
            )
          ],
        )
      ),
    );
  }
}


