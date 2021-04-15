import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sokon/models/ordersItem.dart';

class OrderQuotationWidget extends StatefulWidget {
  final OrderItems resendOrder;

  OrderQuotationWidget({this.resendOrder});

  @override
  _OrderQuotationWidgetState createState() => _OrderQuotationWidgetState();
}

class _OrderQuotationWidgetState extends State<OrderQuotationWidget> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
      height: _expanded ? min(widget.resendOrder.products.length * 30.0 + 150, 200) : 95,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            ListTile(
              title: Text("${widget.resendOrder.username}", style: TextStyle(fontSize: 18.0),),
              subtitle: Text(DateFormat("dd/MM/yyyy HH:mm").format(widget.resendOrder.dateTime)),
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
                duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              height: _expanded ? min(widget.resendOrder.products.length * 20.0 + 100, 100) : 0,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.resendOrder.products.length,
                      itemBuilder: (_, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.resendOrder.products[index].title,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            widget.resendOrder.products[index].quantity,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Tsh ${widget.resendOrder.products[index].price}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text("status"),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){},
                            child: Container(
                                width: 120.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                child: Center(
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                            ),
                          ),
                          Text("Pending", style: TextStyle(color: Colors.green, fontSize: 18.0),),
                          GestureDetector(
                            onTap: (){},
                            child: Container(
                                width: 120.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ],
                      )
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
