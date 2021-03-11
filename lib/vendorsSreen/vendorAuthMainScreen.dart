import 'package:flutter/material.dart';
import 'package:sokon/vendorsSreen/vendorLoginScreen.dart';
import 'package:sokon/vendorsSreen/vendorRegScreen.dart';

class VendorAuthScreen extends StatefulWidget {
  static const String id = 'vendorAuthScreen';
  @override
  _VendorAuthScreenState createState() => _VendorAuthScreenState();
}

class _VendorAuthScreenState extends State<VendorAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Vendor", style: TextStyle(fontSize: 25.0),),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
            tabs: [
              Tab(icon: Icon(Icons.lock, color: Colors.white), text: "Login"),
              Tab(icon: Icon(Icons.perm_contact_calendar, color: Colors.white), text: "Register")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VendorsLogInScreen(),
            VendorRegistration()
          ],
        ),
      ),
    );
  }
}