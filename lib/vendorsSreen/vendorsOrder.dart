import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sokon/heplers/pushNotificationService.dart';
import 'package:sokon/models/message.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';



class VendorsOrder extends StatefulWidget {
  @override
  _VendorsOrderState createState() => _VendorsOrderState();
}

class _VendorsOrderState extends State<VendorsOrder> {

  PushNotificationService pushNotificationService = PushNotificationService();

  @override
  void initState() {
    // pushNotificationService.fetchUsersInfo(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: ListView(
        children: [
          Text('${messageInfo.title}')
        ],
      )
    );
  }
}







// class VendorsOrder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Orders"),
//       ),
//       body: MessagingWidget(),
//     );
//   }
// }
//
//
// class MessagingWidget extends StatefulWidget {
//   @override
//   _MessagingWidgetState createState() => _MessagingWidgetState();
// }
//
// class _MessagingWidgetState extends State<MessagingWidget> {
//   final FirebaseMessaging fcm = FirebaseMessaging();
//   final List<Message> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         final notification = message['notification'];
//         setState(() {
//           messages.add(Message(
//             title: notification['title'],
//             body: notification['body']
//           ));
//         });
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         final notification = message['notification'];
//         setState(() {
//           messages.add(Message(
//               title: notification['title'],
//               body: notification['body']
//           ));
//         });
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         final notification = message['notification'];
//         setState(() {
//           messages.add(Message(
//               title: notification['title'],
//               body: notification['body']
//           ));
//         });
//       },
//     );
//
//     fcm.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: messages.map(buildMessage).toList(),
//     );
//   }
//
//   Widget buildMessage(Message message) => ListTile(
//     title: Text("${message.title}"),
//     subtitle: Text("${message.body}"),
//   );
// }