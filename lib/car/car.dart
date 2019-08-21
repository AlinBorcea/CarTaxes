import 'package:flutter/material.dart';

class Car {

  String _brand;
  String _name;
  String _year;
  Color _color;

  Car(this._brand, this._name, this._year, this._color);

  String get brand => _brand;

  String get name => _name;

  String get year => _year;

  Color get color => _color;


}