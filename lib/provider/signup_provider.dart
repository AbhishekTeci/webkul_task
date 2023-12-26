import 'package:flutter/cupertino.dart';

import '../helper/constant.dart';

class SignupProvider extends ChangeNotifier {

  String? mobile, password,confirmPassword,signUPEmail, username;
  AnimationController? buttonController;

  get getMobilenumber => mobile;
  get getPassword => Password;

  setMobileNumber(String? value){
    mobile = value;
    notifyListeners();
  }


  setSingUp(String? value) {
    signUPEmail = value;
    notifyListeners();
  }

  setUserName(String? value) {
    username = value;
    notifyListeners();
  }





}