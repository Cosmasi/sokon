
import 'package:flutter/material.dart';
import 'package:sokon/authentication.dart';
import 'package:sokon/tools/app_tools.dart';

import 'homeScreen.dart';

class UserLogIn extends StatefulWidget {
  static const String id = "login";
  @override
  _UserLogInState createState() => _UserLogInState();
}

class _UserLogInState extends State<UserLogIn> {
  int line = 1;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var focusLogin = FocusNode();

  bool focused = false;

  void setFocus(){
    if(!focused){
      FocusScope.of(context).requestFocus(focusLogin);
      focused = true;
    }
  }

  Authentication authentication = Authentication();
  
  @override
  Widget build(BuildContext context) {
    setFocus();
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
              focusNode: focusLogin,
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

  verifyLogin() async{
    if (email.text == "") {
      showSnackBar(message: "Email cannot be empty", key: scaffoldKey);
      return;
    } else if (password.text == "") {
      showSnackBar(message: "Password cannot be empty", key: scaffoldKey);
      return;
    }

    displayProgressDialog(context);

    String response = await authentication.loginUser(
      email: email.text.toLowerCase(),
      password: password.text.toLowerCase()
    );

    if(response == "successful"){
      closeProgressDialog(context);
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
    }
  }
}