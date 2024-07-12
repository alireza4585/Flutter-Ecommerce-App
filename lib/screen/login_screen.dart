import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginapi/auth/auth.dart';
import 'package:loginapi/data/bloc/auth_bloc.dart';
import 'package:loginapi/data/bloc/auth_event.dart';
import 'package:loginapi/data/bloc/auth_state.dart';
import 'package:loginapi/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  const LoginScreen({super.key, required this.show});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  final email = TextEditingController();
  final password = TextEditingController();
  bool visibil = true;
  @override
  void initState() {
    super.initState();
    // _focusNode1.addListener(() {
    //   setState(() {});
    // });
    // _focusNode2.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            logo(),
            SizedBox(height: 10.h),
            textfild(),
            SizedBox(height: 15.w),
            textfild2(),
            SizedBox(height: 8.h),
            have(),
            SizedBox(height: 20.h),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthinitState) {
                  return Login();
                }
                if (state is AuthloadingState) {
                  return CircularProgressIndicator();
                }
                if (state is AuthRequestSuccessSate) {
                  Widget widget;
                  state.response.fold((left) {
                    return widget = Login();
                  }, (right) {
                    return widget = Text(right);
                  });
                }
                return Login();
              },
              listener: (context, state) {
                if (state is AuthRequestSuccessSate) {
                  state.response.fold((left) {
                    var snackbar = SnackBar(
                      content: Text(
                        left,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }, (right) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
                  });
                }
              },
            ),
            SizedBox(height: 20.h),
            or(),
            SizedBox(height: 15.h),
            WithGoogle(),
            SizedBox(height: 10.h),
            WithApple(),
          ],
        ),
      ),
    );
  }

  Row or() {
    return Row(
      children: [
        Expanded(
            child: Divider(
          thickness: 1.5.w,
          endIndent: 4,
          indent: 20,
        )),
        Text(
          "OR",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Expanded(
            child: Divider(
          thickness: 1.5.w,
          endIndent: 20,
          indent: 4,
        ))
      ],
    );
  }

  Padding Login() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthBloc>(context)
              .add(AuthLoginRequest(password.text, email.text));
          print(email.text);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Padding WithGoogle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Image.asset(
              'images/google.png',
              height: 30.h,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              'Continue with Google',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: const Icon(
              Icons.arrow_right,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Padding WithApple() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          leading: Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: const Icon(
                Icons.apple,
                color: Colors.black,
              )),
          title: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              'Continue with Apple',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: const Icon(
              Icons.arrow_right,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Padding have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have an account?  ",
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Sign up",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Padding textfild() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: email,
          focusNode: _focusNode1,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(
              Icons.email,
              color: _focusNode1.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding textfild2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: password,
          focusNode: _focusNode2,
          obscureText: visibil,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    visibil = !visibil;
                  });
                },
                child: Icon(
                  visibil ? Icons.visibility_off : Icons.visibility,
                  color: _focusNode2.hasFocus ? Colors.black : Colors.grey[600],
                )),
            hintText: 'Password',
            prefixIcon: Icon(
              Icons.key,
              color: _focusNode2.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: const Color(0xffc5c5c5),
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding logo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Image.asset('images/nikee.png'),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
        ),
        content: Text(message, style: TextStyle(fontSize: 17)),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
