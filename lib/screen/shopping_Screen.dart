import 'package:flutter/material.dart';

class shopping_cart extends StatefulWidget {
  const shopping_cart({super.key});

  @override
  State<shopping_cart> createState() => _shopping_cartState();
}

class _shopping_cartState extends State<shopping_cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('shopping cart'),
      ),
    );
  }
}
