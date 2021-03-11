import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokon/providers/cartProvider.dart';
import 'package:sokon/providers/ordersProvider.dart';
import 'package:sokon/widgets/cart_widgets.dart';

class CartScreen extends StatefulWidget {
  static const String id = "cartScreen";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
        Card(
            margin: EdgeInsets.all(15),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, index) => CartWidget(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].title
              ),
            )
          )
        ],
      ),
    );
  }
}

class OderButton extends StatefulWidget {
  final CartProvider cart;

  const OderButton({this.cart});

  @override
  _OderButtonState createState() => _OderButtonState();
}

class _OderButtonState extends State<OderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
    child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
    onPressed: () async{
      setState(() {
        _isLoading = true;
      });
      await Provider.of<OrdersProvider>(context, listen: false).addOrders(
        widget.cart.items.values.toList()
      );
      setState(() {
        _isLoading = false;
      });
      widget.cart.clearCart();
    },
      textColor: Theme.of(context).primaryColor,
    );
  }
}