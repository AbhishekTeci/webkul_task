import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/constant.dart';


class LoginProvider extends ChangeNotifier {
  String? mobile, password, username, id,otpPara;
  AnimationController? buttonController;
  String errorMessage = '';

  get getMobilenumber => mobile;
  get getPassword => Password;



  get otpvalue => otpPara;

  setOtpValue(String? value){
    otpPara= value;
    notifyListeners();
  }
  setMobileNumber(String? value){
    mobile = value;
    notifyListeners();
  }



}
