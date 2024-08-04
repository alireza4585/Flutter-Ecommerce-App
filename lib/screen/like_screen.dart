import 'package:flutter/material.dart';

class Like_Screen extends StatefulWidget {
  const Like_Screen({super.key});

  @override
  State<Like_Screen> createState() => _Like_ScreenState();
}

class _Like_ScreenState extends State<Like_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Like Screen'),
      ),
    );
  }
}
