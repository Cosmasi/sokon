import 'dart:convert';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sokon/main.dart';
import 'package:sokon/models/cartItems.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:sokon/tools/app_tools.dart';
import 'package:sokon/widgets/notificationDialog.dart';
import 'package:sokon/widgets/progressDialog.dart';

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



  Future<bool> fetchUserOrders(String id, context) async{
    final http.Response response = await
    http.get("https://sokon-79b29-default-rtdb.firebaseio.com/orders/$id.json");
    final Map<String, dynamic> ordersData = json.decode(response.body);

    List<OrderItems> loadeOrders = [];

    ordersData.forEach((key, value) {
      OrderItems data = OrderItems(
        id: key,
        dateTime: DateTime.parse(value['dateTime'].toString()),
        user_id: value["userId"],
        products: (value['products'] as List<dynamic>).map((items) =>
            CartItems(
              id: items['id'].toString(),
              quantity: int.parse(items['quantity'].toString()),
              title: items['title'],
              // price: double.parse(items['price'].toString()),
            ),).toList(),
      );
      // print(data);
      loadeOrders.add(data);
    });
    _ordersReq = loadeOrders.reversed.toList();

    assetsAudioPlayer.open(
      Audio('sounds/alert.mp3'),
    );
    assetsAudioPlayer.play();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => NotificationDialog(orderItem: _ordersReq),
    );

    return Future.value(true);
  }


  static sendNotification(String token, context, String customerId) async{

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ProgressDialog(status: "Sending order...",),
    );

    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    Map notificationMap = {
      'title': 'NEW TRIP REQUEST',
      'body': '$customerId'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'order_id': customerId,
    };

    Map bodyMap = {
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token
    };

    var response = await http.post('https://fcm.googleapis.com/fcm/send',
        headers: headerMap, body: jsonEncode(bodyMap),
    );

    closeProgressDialog(context);
    print(response.body);
  }
}