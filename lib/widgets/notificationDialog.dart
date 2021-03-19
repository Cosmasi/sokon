
import 'package:flutter/material.dart';
import 'package:sokon/models/ordersItem.dart';

class NotificationDialog extends StatelessWidget {


  final List<OrderItems> orderItem;

  NotificationDialog({this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            // SizedBox(height: 30.0,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: orderItem.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Text("${orderItem[index].products.map((e) => e.title).toList()}"),
                  ),
                ),
              ),
            )
          ],
        )
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //
        //     SizedBox(height: 30.0,),
        //
        //     // Image.asset('images/taxi.png', width: 100,),
        //
        //     SizedBox(height: 16.0,),
        //
        //     Text('NEW TRIP REQUEST', style: TextStyle(fontSize: 18),),
        //
        //     SizedBox(height: 30.0,),
        //
        //     Padding(
        //       padding: EdgeInsets.all(16.0),
        //       child: ListView.builder(
        //         itemCount: orderItem.length,
        //         itemBuilder: (_, index) => ListTile(
        //           title: Text("${orderItem[index].title}"),
        //         ),
        //       )
        //     ),
        //   ],
        // ),
      ),
    );
  }


}

