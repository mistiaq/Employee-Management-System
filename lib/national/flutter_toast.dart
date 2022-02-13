import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Common_Toast{
  void customtoast(String msg, Duration duration) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
