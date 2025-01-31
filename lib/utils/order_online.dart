import 'package:flutter/material.dart';
import 'package:food_app_prokit/services/order_class_helper.dart';
import 'package:food_app_prokit/utils/FoodString.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderOnline extends StatefulWidget {
  const OrderOnline({super.key});

  @override
  State<OrderOnline> createState() => _OrderOnlineState();
}

class _OrderOnlineState extends State<OrderOnline> {
  final FirestoreService _firestoreService = FirestoreService();

  void placeOrder() {
    _firestoreService.addOrder('Pizza', 2, 9.99).then((_) {
      print("Order placed successfully!");
    }).catchError((error) {
      print("Failed to place order: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: placeOrder,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(50)),
        child: Text(food_lbl_order_online, style: TextStyle(color: Colors.white)).center(),
      ),
    );
  }
}