import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shopping_app_with_api/auth/auth.dart';
import 'package:flutter_shopping_app_with_api/gitit/gitit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getInitit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: AuthPage()));
  }
}
