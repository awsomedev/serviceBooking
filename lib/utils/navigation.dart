import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Nav {
  static Future navigate(context, page) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page));
  }

  static Future navigateAll(context, page) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }
}

buildToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
