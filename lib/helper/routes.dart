import 'package:flutter/cupertino.dart';
import 'package:webkul_task/views/signup/signup_view.dart';
import '../views/login/login_view.dart';

class Routes{

  static navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }


  static navigateToSignupScreen(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const Signup(),
      ),
    );
  }







}