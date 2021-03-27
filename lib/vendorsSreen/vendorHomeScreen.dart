import 'package:flutter/material.dart';
import 'package:sokon/heplers/pushNotificationService.dart';
import 'package:sokon/vendorsSreen/vendorAuthMainScreen.dart';
import 'package:sokon/vendorsSreen/vendorProfile.dart';
import 'package:sokon/vendorsSreen/vendorsOrder.dart';

import '../authentication.dart';

class VendorHomeScreen extends StatefulWidget {
  static const String id = 'vendorHome';
  @override
  _VendorHomeScreenState createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {

  Authentication authentication = Authentication();

  @override
  void initState() {
    getCurrentVendor(context);
    super.initState();
  }

  Future getCurrentVendor(context) async{
    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.initialize(context);
    pushNotificationService.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Vendor'),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.green[400],
                onPressed: () async{
                  // checkIfLoggedIn();
                  bool response = await authentication.logOutVendor();
                  if(response){
                    Navigator.pushNamedAndRemoveUntil(context, VendorAuthScreen.id, (route) => false);
                  }
                },
                icon: Icon(Icons.exit_to_app, color: Colors.white,),
                label: Text(
                   "LogOut",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (_) => SearchData()));
                      },
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => VendorProfile()));
                        },
                        child: Card(
                          elevation: 5.0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 17.0),
                            child: Row(
                              children: [
                                Icon(Icons.person, size: 30.0, color: Colors.green),
                                SizedBox(width: 10.0),
                                Text('Profile', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (_)=>AddProducts()));
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.add, size: 30.0, color: Colors.green),
                              SizedBox(width: 5.0),
                              Text('Add Product', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => VendorsOrder()));
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 7.0),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Icon(Icons.notifications, size: 30.0, color: Colors.green),
                                  Positioned(
                                    left: 8.0,
                                    child: Container(
                                      width: 16.0,
                                      height: 16.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          color: Colors.red
                                      ),
                                      child: Center(
                                        child: Text("1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      )
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 5.0),
                              Text('App Orders', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 5.0),
                          child: Row(
                            children: [
                              Icon(Icons.history, size: 30.0, color: Colors.green),
                              SizedBox(width: 5.0),
                              Text('Orders History', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => Products()));
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                          child: Row(
                            children: [
                              Icon(Icons.shop, size: 30.0, color: Colors.green),
                              SizedBox(width: 5.0),
                              Text('Products', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (_)=> AddCategory()));
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 7.0),
                          child: Row(
                            children: [
                              Icon(Icons.category, size: 30.0, color: Colors.green),
                              SizedBox(width: 10.0),
                              Text('Add Category', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}