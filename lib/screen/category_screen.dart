import 'package:flutter/material.dart';

class category_Screen extends StatefulWidget {
  const category_Screen({super.key});

  @override
  State<category_Screen> createState() => _category_ScreenState();
}

class _category_ScreenState extends State<category_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Category Screen'),
      ),
    );
  }
}
