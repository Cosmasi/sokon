
import 'package:flutter/material.dart';



class CartWidget extends StatefulWidget {
  final String id;
  final String productId;
  int quantity;
  final String title;
  final double price;

  CartWidget(this.id,this.productId,this.quantity,this.title,this.price);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  increamentCounter(){
    setState(() {
      widget.quantity++;
    });
  }

  decrementCounter(){
    setState(() {
      widget.quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
              ],
            ),
            GestureDetector(
              onTap: decrementCounter,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                      offset: Offset(0.7, 0.7)
                    )
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: FittedBox(
                      child: Text("-", style: TextStyle(fontSize: 50)),
                    ),
                  ),
                ),
              ),
            ),
            Text("${widget.quantity.toString()}"),
            GestureDetector(
              onTap: increamentCounter,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                      offset: Offset(0.7, 0.7)
                    )
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: FittedBox(
                      child: Text("+", style: TextStyle(fontSize: 50)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}