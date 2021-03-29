import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sokon/models/ordersItem.dart';
import 'package:sokon/tools/app_data.dart';

import 'dialogWidget.dart';

class NotificationDialog extends StatefulWidget {

  final List<OrderItems> orderItem;

  NotificationDialog({this.orderItem});

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.orderItem.length,
        itemBuilder: (_, index){
        return DialogWidget(order: widget.orderItem[index]);
        }
    );

  }
}




