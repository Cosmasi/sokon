import 'package:flutter/material.dart';
import 'package:sokon/tools/app_tools.dart';

class VendorRegistration extends StatefulWidget {
  @override
  _VendorRegistrationState createState() => _VendorRegistrationState();
}

class _VendorRegistrationState extends State<VendorRegistration> {
  int line, line2 = 1;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController re_password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.0),
            CircleAvatar(
              maxRadius: 70.0,
              backgroundColor: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.person, size: 70.0, color: Colors.white)],
              ),
            ),
            SizedBox(height: 40),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Full Name',
              textIcon: Icons.person, color: Colors.green,
              controller: fullname,
            ),
            SizedBox(height: 10),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Email',
              textIcon: Icons.email, color: Colors.green,
              controller: email,
            ),
            SizedBox(height: 10.0),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Phone Number',
              textIcon: Icons.phone, color: Colors.green,
              texttype: TextInputType.phone,
              controller: phoneNumber,
            ),
            SizedBox(height: 10.0),
            appTextField2(
              isPassword: line2 == 1?true:false,
              sidePadding: 12.0,
              textHint: 'Password',
              textIcon: Icons.lock, color: Colors.green,
              controller: password,
            ),
            SizedBox(height: 10.0),
            appTextField2(
              isPassword: line == 1 ? true : false,
              sidePadding: 12.0,
              textHint: 'Confirm Password',
              textIcon: Icons.lock, color: Colors.green,
              controller: re_password,
            ),
            appButton(
              buttonText: 'Create An Account',
              buttonPadding: 15.0,
              buttoncolor: Colors.black,
              btnColor: Colors.white,
              // onBtnclick: verifyDetails,
              onBtnclick: (){}
            ),
            SizedBox(height: 10.0),
            Text('Already have an account? Log in here',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}