import 'package:firebase_database/firebase_database.dart';
import 'package:sokon/models/cartItems.dart';

class OrderItems{
  String id;
  String user_id;
  String title;
  double amount;
  List<CartItems> products;
  DateTime dateTime;

  OrderItems({this.id, this.title, this.amount, this.products, this.dateTime,this.user_id});

}