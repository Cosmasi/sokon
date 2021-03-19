
import 'package:firebase_database/firebase_database.dart';

import 'cartItems.dart';

class Message{
  final String title;
  final String body;
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime dateTime;

  Message({this.title, this.body, this.products,this.dateTime,this.amount,this.id});

}