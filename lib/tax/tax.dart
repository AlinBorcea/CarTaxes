import 'package:flutter/material.dart';

class Tax {

  String _title;
  String _description;
  String _date;
  String _time;
  Color _color;

  Tax(this._title, this._description, this._date, this._time, this._color);

  String get title => _title;

  String get description => _description;

  String get date => _date;

  String get time => _time;

  Color get color => _color;

}