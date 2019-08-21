import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_taxes/extra/app_strings.dart';
import 'package:car_taxes/extra/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:car_taxes/main.dart';

class Settings extends StatefulWidget {
  Settings(this._theme);

  final AppTheme _theme;

  @override
  State createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color _appColor;
  int _colorId;

  @override
  void initState() {
    super.initState();
    _appColor = widget._theme.mainColor;

    if (_appColor == Colors.blue)
      _colorId = 0;

    else if (_appColor == Colors.green)
      _colorId = 1;

    else if (_appColor == Colors.red)
      _colorId = 2;

    else if (_appColor == Colors.amber)
      _colorId = 3;

  }

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
      backgroundColor: widget._theme.background,
      appBar: AppBar(
        title: Text('Themes'),
        backgroundColor: widget._theme.mainColor,
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
