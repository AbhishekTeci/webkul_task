import 'package:flutter/material.dart';


setSnackbar(String msg, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SizedBox(
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      duration: const Duration(
        seconds: 2,
      ),
      backgroundColor: Colors.red,
      //behavior: SnackBarBehavior.floating,
      elevation: 1.0,
    ),
  );
}
