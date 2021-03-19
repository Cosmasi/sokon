import 'package:firebase_auth/firebase_auth.dart';
import 'package:sokon/models/message.dart';
import 'package:sokon/models/users.dart';
import 'package:sokon/models/vendors.dart';

// FIREBASE NODES
const String orderNode = "orders";
const String users = "users";
const String vendors = "vendors";


// FIREBASE USER
User firebaseUser;
FirebaseAuth auth = FirebaseAuth.instance;

Message messageInfo;


// PRODUCTS
const String productDescription = "productDescription";
const String productQuantity = "productQuantity";

// String orderID = '';


// USER DETAILS
const String userID = "userID";
const String fullName = "fullName";
const String userEmail = "userEmail";
const String userPassword = "userPassword";
const String phoneNumber = "phoneNumber";
const String photoUrl = "photoUrl";
const String loggedIn = "loggedIn";
const String date = "date";
String created = "created";


// VENDOR DETAILS
const String vendorID = "vendorID";
const String vendorName = "vendorName";
const String vendorEmail = "vendorEmail";
const String vendorPassword = "vendorPassword";
const String vendorPhoneNumber = "vendorPhoneNumber";
const String vendorPhotoUrl = "vendorPhotoUrl";
const String vendorLoggedIn = "loggedIn";
const String vendorDate = "vendorDate";
String vendorCreated = "vendorCreated";


//VENDORS INFO
Vendors vendorsInfo;

//USERS INFO
UsersModel usersInfo;

List<String> localQuantity = [
  "Select a quantity",
  "10",
  "20",
  "30",
  "40",
  "50",
  "60 and above"
];

List<String> localVariation = [
  "Select a type",
  "Small",
  "Medium ",
  "Large ",
  "All Varaitions",
  "No Variation"
];

List<String> localSize = [
  "Select a Size",
  "Small",
  "Medium",
  "Large",
  "Extra Large"
];

List<String> localCategory = [
  "Select product category",
  "Food and Drinks",
  "Clothing",
  "Phones",
  "Computers",
  "Furniture",
  "Fish Bay"
];