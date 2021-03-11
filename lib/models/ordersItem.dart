

import 'package:sokon/models/cartItems.dart';

class OrderItems{
  String id;
  String title;
  double amount;
  List<CartItems> products;
  DateTime dateTime;

  OrderItems({this.id, this.title, this.amount, this.products, this.dateTime});
}