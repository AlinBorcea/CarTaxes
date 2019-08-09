import 'package:car_taxes/extra/app_colors.dart';
import 'package:flutter/material.dart';
import 'car/owner_cars.dart';

main() async {

  Color appColor = await getCurrentColor();
  Color textColor = await getTextColor(appColor);

  runApp(MaterialApp(
    title: 'Car taxes',
    theme: ThemeData(
      primarySwatch: appColor,
    ),
    home: Cars(AppTheme(appColor, textColor, getBackground(false))),
  ));
}
