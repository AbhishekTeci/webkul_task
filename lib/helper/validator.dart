import 'package:flutter/material.dart';

import 'constant.dart';

class StringValidation {

// password verification

  static String? validatePass(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return PASS_REQ;
    } else if (value.length <= 5) {
      return PASS_LENGTH;
    } else {
      return null;
    }
  }

  //mobile verification

  static String? validateMob(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return VAL_MOB;
    }
    if (value.length < 10) {
      return MOB_LEN;
    }
    return null;
  }



}