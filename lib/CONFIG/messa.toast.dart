import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

messageSuccess(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 5, 157, 25),
      textColor: Colors.white,
      fontSize: 16.0);
}
messageError(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:const Color.fromARGB(255, 234, 23, 23),
      textColor: Colors.white,
      fontSize: 16.0);
}
