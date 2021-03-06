import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokon/heplers/pushNotificationService.dart';
import 'package:sokon/providers/cartProvider.dart';
import 'package:sokon/providers/ordersProvider.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:sokon/usersScreen/addProducts.dart';
import 'package:sokon/usersScreen/authMainScreen.dart';
import 'package:sokon/usersScreen/cartScreen.dart';
import 'package:sokon/usersScreen/homeScreen.dart';
import 'package:sokon/usersScreen/profileScreen.dart';
import 'package:sokon/usersScreen/userLogIn.dart';
import 'package:sokon/usersScreen/userRegistration.dart';
import 'package:sokon/vendorsSreen/vendorAuthMainScreen.dart';
import 'package:sokon/vendorsSreen/vendorHomeScreen.dart';
import 'package:sokon/vendorsSreen/vendorLoginScreen.dart';
import 'package:sokon/vendorsSreen/vendorProfile.dart';
import 'package:sokon/vendorsSreen/vendorRegScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeScreen()
        initialRoute: HomeScreen.id,
        
        routes: {
          UserRegistration.id: (_) => UserRegistration(),
          UserLogIn.id: (_) => UserLogIn(),
          HomeScreen.id: (_) => HomeScreen(),
          ProfileScreen.id: (_) => ProfileScreen(),
          AddProducts.id: (_) => AddProducts(),
          UserAuthScreen.id: (_) => UserAuthScreen(),
          CartScreen.id: (_) => CartScreen(),
          VendorHomeScreen.id: (_) => VendorHomeScreen(),
          VendorRegistration.id: (_) => VendorRegistration(),
          VendorAuthScreen.id: (_) => VendorAuthScreen(),
          VendorsLogInScreen.id: (_) => VendorsLogInScreen(),
          VendorProfile.id: (_) => VendorProfile()
        },
      ),
    );
  }
}