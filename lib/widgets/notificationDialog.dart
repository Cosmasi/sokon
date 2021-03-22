import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';

class NotificationDialog extends StatelessWidget {

  final List<OrderItems> orderItem;

  NotificationDialog({this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.0,),
            Image.asset('assets/images/taxi.png', width: 100,),
            SizedBox(height: 16.0,),
            Text('NEW ORDER REQUEST', style: TextStyle(fontSize: 18),),
            Divider(thickness: 1.0,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: orderItem.length,
                    shrinkWrap: true,
                  itemBuilder: (_, index) =>  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Text(
                              "${orderItem[index].products.map((e) => e.title).join("\n")} \n",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
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
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Center(
                        child: Text("ACCEPT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15.0)
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


