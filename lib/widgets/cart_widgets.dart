
import 'dart:ui';

import 'package:flutter/material.dart';



class CartWidget extends StatefulWidget {
  final String id;
  final String productId;
  final String quantity;
  final String title;
  // final double price;

  CartWidget(this.id,this.productId,this.quantity,this.title);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  // increamentCounter(){
  //   setState(() {
  //     widget.quantity++;
  //   });
  // }

  // decrementCounter(){
  //   setState(() {
  //     widget.quantity--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Text(widget.title, style: TextStyle(fontSize: 18.0, color: Colors.black)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Unit measure", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Text(
                  "${widget.quantity.toString()}",
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}