import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/home_bloc/home_event.dart';
import 'package:flutter_shopping_app_with_api/screen/category_screen.dart';
import 'package:flutter_shopping_app_with_api/screen/home_screen.dart';
import 'package:flutter_shopping_app_with_api/screen/like_screen.dart';
import 'package:flutter_shopping_app_with_api/screen/profileScreen.dart';
import 'package:flutter_shopping_app_with_api/screen/shopping_Screen.dart';

class Navigation_Screen extends StatefulWidget {
  const Navigation_Screen({super.key});

  @override
  State<Navigation_Screen> createState() => _Navigation_ScreenState();
}

int index = 0;
List screen = [
  BlocProvider(
    create: (context) {
      var bloc = HomeBloc();
      bloc.add(HomeGetInitilzeData());
      return bloc;
    },
    child: HomeScreen(),
  ),
  category_Screen(),
  shopping_cart(),
  Like_Screen(),
  Profile_SCreen(),
];

class _Navigation_ScreenState extends State<Navigation_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            index = 2;
          });
        },
        child: Icon(Icons.shopping_cart_outlined),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.w,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    index = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  size: 27.w,
                  color: index == 0 ? Colors.black : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },
                icon: Icon(
                  Icons.category,
                  size: 27.w,
                  color: index == 1 ? Colors.black : Colors.grey,
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: () {
                  setState(() {
                    index = 3;
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  size: 27.w,
                  color: index == 3 ? Colors.black : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    index = 4;
                  });
                },
                icon: Icon(
                  Icons.person,
                  size: 27.w,
                  color: index == 4 ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: screen[index],
    );
  }
}
