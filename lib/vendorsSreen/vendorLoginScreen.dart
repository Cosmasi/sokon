import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:sokon/tools/app_tools.dart';
import 'package:sokon/usersScreen/homeScreen.dart';
import 'package:sokon/vendorsSreen/vendorHomeScreen.dart';

import '../authentication.dart';

class VendorsLogInScreen extends StatefulWidget {
  static const String id = 'vendorLogin';
  @override
  _VendorsLogInScreenState createState() => _VendorsLogInScreenState();
}

class _VendorsLogInScreenState extends State<VendorsLogInScreen> {
  int line = 1;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Authentication authentication = Authentication();

  DatabaseReference tripRequestRef;
  User currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: Colors.green,
              maxRadius: 70.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.lock_open,size: 70.0,color: Colors.white,),
                ],
              ),
            ),
            SizedBox(height: 70.0),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Email',
              textIcon: Icons.email, color: Colors.green,
              controller: email,
            ),
            SizedBox(height: 12.0),
            appTextField2(
              isPassword: line == 1?true:false,
              sidePadding: 12.0,
              textHint: 'Password',
              textIcon: Icons.lock, color: Colors.green,
              controller: password,
            ),
            SizedBox(height:2.0),
            appButton(
                buttonText: 'Login',
                buttonPadding: 10.0 ,
                buttoncolor: Colors.black,
                btnColor: Colors.white,
                onBtnclick: verifyLogin,
            ),
            SizedBox(height: 10.0),
            Text('Forgot password ?',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  void verifyLogin() async{
    if (email.text == "") {
    showSnackBar(message: "Email cannot be empty", key: scaffoldKey);
    return;
    } else if (password.text == "") {
    showSnackBar(message: "Password cannot be empty", key: scaffoldKey);
    return;
    }

    displayProgressDialog(context);

    String response = await authentication.loginVendor(
    vEmail: email.text.toString(),
    vPassword: password.text.toString(),
    );

    if(response == "successful"){
    closeProgressDialog(context);
    goOnline();
    Navigator.pushNamedAndRemoveUntil(context, VendorHomeScreen.id, (route) => false);
    }
  }

  void goOnline() async {
    try{
      currentUser = FirebaseAuth.instance.currentUser;
      Geofire.initialize('vendorsAvailable');
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

      Geofire.setLocation(currentUser.uid, position.latitude, position.longitude);
      tripRequestRef = FirebaseDatabase.instance.reference().child(vendors)
          .child(currentUser.uid).child("newtrip");

      tripRequestRef.set('waiting');

      tripRequestRef.onValue.listen((event) {

      });
    }catch(e){
      print(e);
    }
  }
}