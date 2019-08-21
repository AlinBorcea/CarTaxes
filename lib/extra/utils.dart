import 'package:fluttertoast/fluttertoast.dart';
import 'package:car_taxes/extra/app_colors.dart';
import 'package:flutter/material.dart';

displayToast(AppTheme theme, String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: theme.mainColor,
      textColor: theme.textColor,
      fontSize: 16.0,
  );
}
