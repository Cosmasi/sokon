import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokon/providers/ordersProvider.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:sokon/widgets/orderQuotationWidget.dart';

class OrderQuotation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final resend = Provider.of<OrdersProvider>(context);
    resend.fetchResendOrder();
    print("MY ID $vID");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orders Quotation"),
          elevation: 0.0,
        ),
        body: resend.resendOrders.isNotEmpty ? ListView.builder(
          itemCount: resend.resendOrders.length,
          itemBuilder: (_, index) => OrderQuotationWidget(
            resendOrder: resend.resendOrders[index],
          ),
        )
        : Center(child: CircularProgressIndicator(strokeWidth: 2.0))
      ),
    );
  }
}
