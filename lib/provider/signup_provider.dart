import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class SignupProvider extends ChangeNotifier {

  String? mobile,signUPEmail, username;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? signupOtpCode;

  AnimationController? buttonController;

  get getMobilenumber => mobile;
  get getEmailId => signUPEmail;
  get getSignupOtpCode => signupOtpCode;

  setMobileNumber(String? value){
    mobile = value;
    notifyListeners();
  }

  setOtpCode(String? otp){
    signupOtpCode = otp;
    notifyListeners();
  }


  setSingUpEmail(String? value) {
    signUPEmail = value;
    notifyListeners();
  }

  setUserName(String? value) {
    username = value;
    notifyListeners();
  }








}