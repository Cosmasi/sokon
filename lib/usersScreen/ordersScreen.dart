import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/providers/ordersProvider.dart';
import 'package:sokon/widgets/ordersWidget.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderItems orderItems;

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: FutureBuilder(
          future: orders.fetchOrders(),
          builder: (_, dataSnapshot){
            if(dataSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
            }else{
              if(!dataSnapshot.hasData){
                return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
              }
              else{
                return ListView.builder(
                  itemCount: orders.orders.length,
                  itemBuilder: (_, index) => OrdersWidget(order: orders.orders[index],),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
