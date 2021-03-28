import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sokon/models/nearByVendor.dart';
import 'package:sokon/providers/cartProvider.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:sokon/tools/app_tools.dart';
import 'package:sokon/usersScreen/addProducts.dart';
import 'package:sokon/usersScreen/authMainScreen.dart';
import 'package:sokon/usersScreen/ordersScreen.dart';
import 'package:sokon/usersScreen/profileScreen.dart';
import 'package:sokon/vendorsSreen/vendorAuthMainScreen.dart';

import '../authentication.dart';
import 'cartScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "homeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size screenSize;



  String vendorName;
  String vendorPhone;

  Authentication authentication = Authentication();


  @override
  void initState() {
    getCurrentUser();
    // startGeoFire();
    super.initState();
  }
  
  void getVendorInfo(NearbyVendor nearbyVendor) {
    DatabaseReference vendorRef = FirebaseDatabase.instance.reference()
    .child(vendors).child(nearbyVendor.key);

    vendorRef.once().then((DataSnapshot snapshot){
      if(snapshot.value !=null){
        token = snapshot.value['token'];
        vendorName = snapshot.value['vendorName'].toString();
        vendorPhone = snapshot.value['vendorPhoneNumber'];
      }
    });
    print("VENDOR TOKEN:: $token}");
  }


  Future getCurrentUser() async{
    accountName = await getStringDataLocally(key: fullName);
    accountEmail = await getStringDataLocally(key: userEmail);
    isLoggedin = await getBoolDataLocally(key: loggedIn);
    phoneN = await getStringDataLocally(key: phoneNumber);
    print(await getStringDataLocally(key: phoneNumber));
    accountName == null ? accountName = "Guest User" : accountName;
    accountEmail == null ? accountEmail = "guestuser@gmail.com" : accountEmail;

    setState(() {});
  }

  checkIfLoggedIn()async{
    if(isLoggedin == false){
      bool response = await Navigator.of(context)
      .push(MaterialPageRoute<bool>(builder: (_) => UserAuthScreen()));

    if (response == true) getCurrentUser();
    return;
    }
    _alertDialogue(context, "Do you really want to logout", "Log Out");
  }


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    screenSize = MediaQuery.of(context).size;
    startGeoFire();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: GestureDetector(
            onLongPress: () =>  Navigator.push(context, MaterialPageRoute(builder: (_) => VendorAuthScreen())),
            child: Text("Sokon App", style: TextStyle(fontSize: 22.0),)),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.green[400],
                onPressed: (){
                  checkIfLoggedIn();
                },
                icon: Icon(Icons.exit_to_app, color: Colors.white,),
                label: Text(
                  isLoggedin == true ? "LogOut" : "LogIn",
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
                // SizedBox(height: 50.0),
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
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddProducts()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (_) => OrdersScreen()));
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 7.0),
                          child: Row(
                            children: [
                              Icon(Icons.notifications, size: 30.0, color: Colors.green),
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
        floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: [
          FloatingActionButton(
            elevation: 0.0,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
            },
            child: Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: Text(
              cart.items.length == 0 ? "0" : "${cart.items.length}",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      ),
    );
  }


  Future _alertDialogue(BuildContext context,String message,String header)async{
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text(header),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child:Text("Cancel"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:Text("Ok"),
              onPressed: () async {
              setState(() {

              });
              bool response = await authentication.logOutUser();
              if(response == true) getCurrentUser();
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      }
    );
  }



  void startGeoFire() async{
    Geofire.initialize('vendorsAvailable');
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

    Geofire.queryAtLocation(position.latitude, position.longitude, 5).listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered:
            // keysRetrieved.add(map["key"]);
           NearbyVendor nearbyVendor = NearbyVendor(
            key: map['key'],
            latitude: map['latitude'],
            longitude: map['longitude']
          );
           getVendorInfo(nearbyVendor);
           break;

          case Geofire.onKeyExited:
            // keysRetrieved.remove(map["key"]);
            break;

          case Geofire.onKeyMoved:
          // Update your key's location
            break;

          case Geofire.onGeoQueryReady:
          // All Intial Data is loaded
            print(map['result']);

            break;
        }
      }
    });
    // setState(() {});
  }
}