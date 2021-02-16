import 'package:admincoinacc/models/cart_item_model.dart';
import 'package:admincoinacc/models/fetch_order_details.dart';
import 'package:admincoinacc/models/order.dart';
import 'package:admincoinacc/orderServices/get_orders_list.dart';
import 'package:admincoinacc/providers/order_provider.dart';
import 'package:admincoinacc/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  String userName;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: CustomText(text: "Mes commandes"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: orderProvider.orders.length,
          itemBuilder: (_, index) {
            OrderModel order = orderProvider.orders[index];
            return Container(
              child: Column(
                children: [
                  ListTile(
                    leading: CustomText(
                      text: "${order.total} \F\C\F\A",
                      weight: FontWeight.bold,
                      size: 21,
                    ),
                    title: Text(order.name + "  " + order.surname),
                    subtitle: Text(
                        DateTime.fromMillisecondsSinceEpoch(order.createdAt)
                            .toString()),
                    trailing: CustomText(
                      text: order.status,
                      color: Colors.green,
                    ),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        order.id,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: CustomText(
                      text: order.telephone,
                      color: Colors.red,
                    ),
                  ),
                  Column(
                    children: order.cart
                        .map((item) => GestureDetector(
                      child:ListTile(
                        title: Text(item["name"].toString()),
                        subtitle: Text(item["amount"].toString() + " X unite   "+item["price"].toString() + " FCFA" ) ,
                        isThreeLine: true,
                      ),
                    )).toList(),
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.grey,
                  )
                ],
              ),
            );
          }),
    );
  }
}
