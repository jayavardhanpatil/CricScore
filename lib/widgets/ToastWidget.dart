
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSuccessColoredToast(String message) {
   Fluttertoast.showToast(
    msg: message,
    backgroundColor: Color.fromRGBO(44, 213, 83, 0.4),
    textColor: Colors.black87,
    gravity: ToastGravity.BOTTOM,
  );
}

void showFailedColoredToast(String message) {
   Fluttertoast.showToast(
    msg: message,
    backgroundColor: Color.fromRGBO(252, 26, 10, 0.4),
    textColor: Colors.black87,
    gravity: ToastGravity.BOTTOM,
  );
}