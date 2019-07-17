import 'package:flutter/material.dart';

class Tax {

  String _title;
  String _description;
  DateTime _date;
  TimeOfDay _time;

  Tax(this._title, this._description, this._date, this._time);

  String get title => _title;

  String get description => _description;

  DateTime get date => _date;

  TimeOfDay get time => _time;


}