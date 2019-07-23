import 'package:car_taxes/extra/app_colors.dart';
import 'package:flutter/material.dart';
import 'car/owner_cars.dart';

main() async {

  Color _appColor = await getCurrentColor();
  Color textColor = await getTextColor(_appColor);

  runApp(MaterialApp(
    title: 'Car taxes',
    theme: ThemeData(
      primarySwatch: _appColor,
    ),
    home: Cars(AppTheme(_appColor, textColor, getBackground(false))),
  ));
}
