import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginapi/data/bloc/auth_bloc.dart';
import 'package:loginapi/data/bloc/auth_event.dart';
import 'package:loginapi/data/bloc/auth_state.dart';
import 'package:loginapi/screen/home_screen.dart';

class SignUPScreen extends StatefulWidget {
  final VoidCallback show;
  const SignUPScreen({super.key, required this.show});

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  FocusNode _focusNode3 = FocusNode();
  final Confirmpassword = TextEditingController();
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
            textfild(),
            SizedBox(height: 15.h),
            textfild1(),
            SizedBox(height: 15.w),
            textfild2(),
            SizedBox(height: 15.w),
            textfild3(),
            SizedBox(height: 8.h),
            have(),
            SizedBox(height: 20.h),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthinitState) {
                  return signIN();
                }
                if (state is AuthloadingState) {
                  return CircularProgressIndicator();
                }
                if (state is AuthRequestSuccessSate) {
                  Widget widget;
                  state.response.fold((left) {
                    return widget = signIN();
                  }, (right) {
                    return widget = Text(right);
                  });
                }
                return signIN();
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
            SizedBox(height: 15.h),
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

  Padding signIN() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthBloc>(context).add(AuthRegisterRequest(
              email.text, password.text, Confirmpassword.text, name.text));
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
            'Sign In',
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
            "Already have an account?  ",
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Login",
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

  Padding textfild1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: name,
          focusNode: _focusNode4,
          decoration: InputDecoration(
            hintText: 'Name',
            prefixIcon: Icon(
              Icons.email,
              color: _focusNode4.hasFocus ? Colors.black : Colors.grey[600],
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

  Padding textfild3() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: Confirmpassword,
          focusNode: _focusNode3,
          obscureText: visibil,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            hintText: 'Confirmpassword',
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
      padding: EdgeInsets.symmetric(horizontal: 90.w),
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
        content: Text(message, style: TextStyle(fontSize: 17.sp)),
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
