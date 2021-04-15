import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sokon/models/ordersItem.dart';

class OrdersWidget extends StatefulWidget {
  final OrderItems order;

  OrdersWidget({this.order});

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      height: _expanded ? min(widget.order.products.length * 20.0 + 150, 200) : 95,
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(DateFormat("dd/MM/yyyy HH:mm").format(widget.order.dateTime)),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(microseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              height: _expanded ? min(widget.order.products.length * 20.0 + 50, 100) : 0,
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (_, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.products[index].title,
                      style: TextStyle(fontSize: 18),
                    ),
                    // Text(
                    //   '${widget.order.products[index].quantity}x Tsh ${widget.order.products[index].price}',
                    //   style: TextStyle(fontSize: 18,color: Colors.grey),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
