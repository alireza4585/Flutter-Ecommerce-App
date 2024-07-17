import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/auth_bloc.dart';
import 'package:flutter_shopping_app_with_api/screen/login_screen.dart';
import 'package:flutter_shopping_app_with_api/screen/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void go() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return BlocProvider(
        create: (context) => AuthBloc(),
        child: LoginScreen(show: go),
      );
    } else {
      return BlocProvider(
        create: (context) => AuthBloc(),
        child: SignUPScreen(show: go),
      );
    }
  }
}
