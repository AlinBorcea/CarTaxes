import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_strings.dart';

Color chillWhite = Color.fromARGB(255, 245, 245, 245);

///rgb(245, 245, 245)
Color skyBlue = Color.fromARGB(255, 0, 176, 255);

///rgb(0, 176, 255)

Future<Color> getCurrentColor() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();

  const int _skyBlue = 0;
  const int _grassGreen = 1;
  const int _bloodRed = 2;
  const int _amber = 3;

  switch (_pref.getInt(themeId)) {
    case _skyBlue:
      return Colors.blue;

    case _grassGreen:
      return Colors.green;

    case _bloodRed:
      return Colors.red;

    case _amber:
      return Colors.amber;
  }

  return Colors.blue;
}
