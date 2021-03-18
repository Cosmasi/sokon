import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sokon/tools/app_data.dart';

class PushNotificationService{

  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize() async{
    if(Platform.isIOS){
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },

      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
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
}