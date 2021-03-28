import 'package:flutter/material.dart';
import 'package:sokon/tools/app_tools.dart';
import 'package:sokon/vendorsSreen/vendorHomeScreen.dart';

import '../authentication.dart';

class VendorRegistration extends StatefulWidget {
  static const String id = 'vendorReg';
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

  Authentication authentication = Authentication();

  var focusRegistration = FocusNode();

  bool focused = false;

  void setFocus(){
    if(!focused){
      FocusScope.of(context).requestFocus(focusRegistration);
      focused = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
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
              focusNode: focusRegistration,
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
              onBtnclick: verifyDetails,
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


  verifyDetails() async{
    if (fullname.text == "") {
      showSnackBar(message: " Full name cannot be empty", key: scaffoldKey);
      return;
    }
    if (email.text == "") {
      showSnackBar(message: "Email cannot be empty", key: scaffoldKey);
      return;
    }
    if (password.text == "" || password.text.length < 6) {
      showSnackBar(message: "Password cannot be empty or passord is too short",key: scaffoldKey);
      return;
    }
    if (re_password.text == "") {
      showSnackBar(message: "Please re-enter your password", key: scaffoldKey);
      return;
    }
    if (password.text != re_password.text) {
      showSnackBar(message: "Passwords don't match", key: scaffoldKey);
      return;
    }
    if (phoneNumber.text == "") {
      showSnackBar(message: "Please enter your phone number", key: scaffoldKey);
      return;
    }

    displayProgressDialog(context);

    String response = await authentication.createVendor(
        vName: fullname.text.toLowerCase(),
        vEmail: email.text.toLowerCase(),
        vPassword: password.text.toLowerCase(),
        vPhone: phoneNumber.text.toLowerCase()
    );

    if(response == "successful"){
      closeProgressDialog(context);
      Navigator.pushNamedAndRemoveUntil(context, VendorHomeScreen.id, (route) => false);
    }else{
      closeProgressDialog(context);
      showSnackBar(message: "Error", key: scaffoldKey);
    }
  }
}