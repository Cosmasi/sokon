
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sokon/models/cartItems.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';

class OrdersProvider with ChangeNotifier{
  List<OrderItems> _orders = [];

  List<OrderItems> get orders => List.from(_orders);

  DatabaseReference orderRef = FirebaseDatabase.instance.reference().child(orderNode).push();
  // User currentUser = FirebaseAuth.instance.currentUser;
  
  Future<void> addOrders(List<CartItems> cartProducts) async{
    String ordersKey = orderRef.push().key;
    final timestamp = DateTime.now();
    orderRef.set({
      "products": cartProducts.map((product) => {
        "id": product.id,
        "title": product.title,
        "quantity": product.quantity,
        "selectedQty": product.selectedQty
      }).toList(),
      "dateTime": timestamp.toIso8601String(),
    });
    _orders.insert(0, OrderItems(
      id: ordersKey,
      products: cartProducts,
      dateTime: timestamp
    ));
    notifyListeners();
  }
}