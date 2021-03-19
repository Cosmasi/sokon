import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sokon/models/cartItems.dart';
import 'package:sokon/models/message.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:sokon/tools/app_tools.dart';
import 'package:sokon/widgets/notificationDialog.dart';

class PushNotificationService{

  List<OrderItems> _ordersReq = [];

  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize(context) async{
    if(Platform.isIOS){
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        fetchUserOrders(getOrderID(message), context);
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        fetchUserOrders(getOrderID(message), context);
      },

      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        fetchUserOrders(getOrderID(message), context);
      },

    );
  }

  Future<String> getToken() async{
    User firebaseUser = FirebaseAuth.instance.currentUser;
    String token = await fcm.getToken();
    print('token: $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance.reference()
        .child(vendors).child(firebaseUser.uid).child('token');
    tokenRef.set(token);

    fcm.subscribeToTopic('allVendors');
    fcm.subscribeToTopic('allUsers');

    return token;
  }

  String getOrderID(Map<String, dynamic> message){

    String orderID = '';

    if(Platform.isAndroid){
      orderID = message['data']['order_id'];
      print('order_id:: $orderID');
    }
    else{
      orderID = message['data']['order_id'];
      print('order_id:: $orderID');
    }

    return orderID;
  }


  // Future fetchUsersInfo(context) async{
  //
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => displayProgressDialog(context)
  //   );
  //
  //   DatabaseReference orderRef = FirebaseDatabase.instance.reference().child(orderNode);
  //   User currentUser = FirebaseAuth.instance.currentUser;
  //
  //   orderRef.child(userID).once().then((DataSnapshot snapshot){
  //     closeProgressDialog(context);
  //
  //     Map<dynamic, dynamic> values = snapshot.value;
  //
  //     values.forEach((key, data) {
  //       Message message = Message(
  //         id: key,
  //         dateTime: DateTime.parse(data['dateTime'].toString()),
  //         products: (data['products'] as List<dynamic>).map((items) => CartItems(
  //           id: items['id'].toString(),
  //           quantity: int.parse(items['quantity'].toString()),
  //           title: items['title'],
  //         )
  //         ).toList()
  //       );
  //       messageInfo = message;
  //     });
  //   });
  //
  //   showDialog(
  //       context: context,
  //       builder: (context) => NotificationDialog(message: messageInfo)
  //   );
  //
  // }


  Future<bool> fetchUserOrders(String id, context) async{
    final http.Response response = await
    http.get("https://sokon-79b29-default-rtdb.firebaseio.com/orders/$id.json");
    final Map<String, dynamic> ordersData = json.decode(response.body);

    List<OrderItems> loadeOrders = [];

    ordersData.forEach((key, value) {
      OrderItems data = OrderItems(
        id: key,
        dateTime: DateTime.parse(value['dateTime'].toString()),
        products: (value['products'] as List<dynamic>).map((items) =>
            CartItems(
              id: items['id'].toString(),
              quantity: int.parse(items['quantity'].toString()),
              title: items['title'],
            )).toList(),
      );
      print(data);
      loadeOrders.add(data);
    });
    _ordersReq = loadeOrders.reversed.toList();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => NotificationDialog(orderItem: _ordersReq),
    );

    return Future.value(true);
  }


}