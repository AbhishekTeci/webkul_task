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

  static String? validateEmail(String value, String? msg1, String? msg2) {
    if (value.isEmpty) {
      return msg1;
    } else if (!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
        r'*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+'
        r'[a-z0-9](?:[a-z0-9-]*[a-z0-9])?')
        .hasMatch(value)) {
      return msg2;
    } else {
      return null;
    }
  }

  static String? validateUserName(String value, String? msg1, String? msg2) {
    if (value.isEmpty) {
      return msg1;
    }
    if (value.length <= 1) {
      return msg2;
    }
    return null;
  }



}