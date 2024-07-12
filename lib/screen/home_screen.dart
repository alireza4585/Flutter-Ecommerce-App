import 'package:flutter/material.dart';
import 'package:loginapi/auth/auth.dart';
import 'package:loginapi/util/auth_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              AuthManager.logout();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AuthPage(),
                ),
              );
            },
            child: Text('logout')),
      ),
    );
  }
}
