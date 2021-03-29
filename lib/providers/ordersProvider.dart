import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sokon/models/cartItems.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier{
  List<OrderItems> _orders = [];

  List<OrderItems> get orders => List.from(_orders);

  User currentUser = FirebaseAuth.instance.currentUser;

  DatabaseReference orderRef = FirebaseDatabase.instance.reference().child(orderNode);

  Future<String> addOrders(List<CartItems> cartProducts) async{
    String ordersKey = orderRef.push().key;
    final timestamp = DateTime.now();

    orderRef.child(currentUser.uid).push().set({
      "products": cartProducts.map((product) => {
        "id": product.id,
        "title": product.title,
        "quantity": product.quantity.toString(),
        "price": product.price.toString(),
        "selectedQty": product.selectedQty.toString()
      }).toList(),
      "dateTime": timestamp.toIso8601String(),
      "userId": currentUser.uid,
      "userName": accountName,
      "phone": phoneN,
    });
    _orders.insert(0, OrderItems(
      id: ordersKey,
      products: cartProducts,
      dateTime: timestamp
    ));
    notifyListeners();
    return "success";
  }



  Future<bool> fetchOrders() async{
    final http.Response response = await
    http.get("https://sokon-79b29-default-rtdb.firebaseio.com/orders/${currentUser.uid}.json");
    final Map<String, dynamic> ordersData = json.decode(response.body);

    List<OrderItems> loaderOrders = [];

    ordersData.forEach((key, value) {
      // print(_orders);
      OrderItems data = OrderItems(
        id: key,
        // amount: double.parse((value['amount'].toString())),
        dateTime: DateTime.parse(value['dateTime'].toString()),
        products: (value['products'] as List<dynamic>).map((items) =>
            CartItems(
              id: items['id'].toString(),
              // price: double.parse(items['price'].toString()),
              quantity: int.parse(items['quantity'].toString()),
              title: items['title'],
            )).toList(),
      );
      print(data);
      loaderOrders.add(data);
    });
    _orders = loaderOrders.reversed.toList();
    notifyListeners();
    return Future.value(true);
  }
}