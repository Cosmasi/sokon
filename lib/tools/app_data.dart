import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

final assetsAudioPlayer = AssetsAudioPlayer();

//TOKEN
String token;

String serverKey = 'AAAA1hlL34g:APA91bGj0VsbVe26VxU57Koq93pdoC3Kgv8c2oyw59E5qaUbnNYbYa4_V8Ep1JHXpjwi68OEkxlaeVUV5tms8OsyYR6gZXBwYFKgieWJbxUNGqJAULdPpahOrPIBK3TOE7_SpxM8ab3L';



// PRODUCTS
const String productDescription = "productDescription";
const String productQuantity = "productQuantity";

// USERS INFO
String accountName = "";
String accountEmail = "";
bool isLoggedin = true;
String phoneN = "";

String vID;
// String vName;
// String vPhone;


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
  "10Kg",
  "20Kg",
  "30Kg",
  "40Kg",
  "50Kg",
  "60Kg and above"
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