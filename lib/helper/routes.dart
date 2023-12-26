import 'package:flutter/cupertino.dart';
import 'package:webkul_task/views/dashboard/dashboard.dart';
import 'package:webkul_task/views/signup/signup_view.dart';
import '../views/login/login_view.dart';
import '../views/movie_detail/movie_detail_view.dart';
import '../views/otp_verification/verify_otp.dart';

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


  static navigateToDashboard(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (BuildContext context) => const Dashboard()),
        ModalRoute.withName('/home'));

  }

  static navigateToMovieDetailView(BuildContext context,String movieName,String movieDesc,String movImg) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>  MovieDetailView(movDesc: movieDesc,movImg: movImg,movName: movieName),
      ),
    );
  }


  static navigateToVerifyOtpView(BuildContext context,String mobNumber) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>  VerifyOtp(mobileNo: mobNumber,),
      ),
    );
  }



}