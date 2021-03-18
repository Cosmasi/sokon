import 'package:firebase_database/firebase_database.dart';
import 'package:sokon/models/cartItems.dart';

class OrderItems{
  String id;
  String title;
  double amount;
  List<CartItems> products;
  DateTime dateTime;

  OrderItems({this.id, this.title, this.amount, this.products, this.dateTime});

  // OrderItems.fromSnapshot(DataSnapshot snapshot){
  //   id = snapshot.key;
  //   title = snapshot.value['title'];
  //   amount = double.parse(snapshot.value['title'].toString());
  //   dateTime = DateTime.parse(snapshot.value['datetime'].toString());
  //   products: (snapshot.value['products'] as List<dynamic>).map((items) =>
  //       CartItems(
  //         id: items['id'].toString(),
  //         // price: double.parse(items['price'].toString()),
  //         quantity: int.parse(items['quantity'].toString()),
  //         title: items['title'],
  //       )
  //   ).toList();
  // }
}