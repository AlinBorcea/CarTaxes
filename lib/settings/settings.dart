import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_taxes/app_strings.dart';
import 'package:car_taxes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:car_taxes/main.dart';

class Settings extends StatefulWidget {
  @override
  State createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color _appColor;
  int _colorId;

  setAppColor(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(themeId, id);
  }

  radioTile(int id, String name, Color color) {
    return RadioListTile(
      value: color,
      groupValue: id,
      title: Text(name),
      selected: _colorId == id,
      onChanged: (color) {
        setState(() {
          _appColor = color;
          _colorId = id;
        });
        setAppColor(id);
        main();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chillWhite,
      appBar: AppBar(
        title: Text('Themes'),
        backgroundColor: _appColor,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            radioTile(0, 'Blue', Colors.blue),
            radioTile(1, 'Green', Colors.green),
            radioTile(2, 'Red', Colors.red),
            radioTile(3, 'Amber', Colors.amber),
          ],
        ),
      ),
    );
  }
}
