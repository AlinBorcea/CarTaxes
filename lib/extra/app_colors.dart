import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_taxes/extra/app_strings.dart';

class AppTheme {

  Color _mainColor;
  Color _textColor;
  Color _background;

  AppTheme(this._mainColor, this._textColor, this._background);

  Color get mainColor => _mainColor;

  Color get textColor => _textColor;

  Color get background => _background;

}

Color chillWhite = Color.fromARGB(255, 245, 245, 245); ///rgb(245, 245, 245)
Color skyBlueColor = Color.fromARGB(255, 0, 176, 255); ///rgb(0, 176, 255)

/// Preferences
final String themeId = 'ThemeNumber';
const int skyBlue = 0;
const int grassGreen = 1;
const int bloodRed = 2;
const int amber = 3;

Future<Color> getCurrentColor() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();

  switch (_pref.getInt(themeId)) {
    case skyBlue:
      return Colors.blue;

    case grassGreen:
      return Colors.green;

    case bloodRed:
      return Colors.red;

    case amber:
      return Colors.amber;
  }

  return Colors.blue;
}

Future<Color> getTextColor(Color currentColor) async {

    if (currentColor == Colors.blue || currentColor == Colors.green || currentColor == Colors.red)
    return Colors.white;

  return Colors.black;
}

getBackground(bool isDark) {
  return isDark ? Colors.grey : chillWhite;
}