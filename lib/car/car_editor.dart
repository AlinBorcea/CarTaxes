import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:car_taxes/database/firestore_helper.dart';
import 'package:car_taxes/extra/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:car_taxes/extra/utils.dart';
import 'car.dart';

class EditCar extends StatefulWidget {
  EditCar(this._theme, this._car);

  final AppTheme _theme;
  final Car _car;

  @override
  State createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  Color _carColor = Colors.blue;

  String _brand = '';
  String _name = '';
  String _year = '';

  bool _dataIsValid() {
    if (_brand == '') {
      displayToast(widget._theme, 'Invalid brand!');
      return false;
    }

    if (_name == '') {
      displayToast(widget._theme, 'Invalid name!');
      return false;
    }

    int year;
    try {
      year = int.parse(_year);
    } catch (e) {
      displayToast(widget._theme, 'Invalid year');
      return false;
    }

    if (year < 1885 || year > DateTime.now().year) {
      displayToast(widget._theme, 'Invalid year');
      return false;
    }

    return true;
  }

  Future<void> displayDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Possible colors'),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: MaterialColorPicker(
              selectedColor: _carColor,
              onColorChange: (Color color) {
                setState(() {
                  _carColor = color;
                });
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._theme.background,
      appBar: AppBar(
        title: Text(
          'Add car',
          style: TextStyle(
            color: widget._theme.textColor,
          ),
        ),
        backgroundColor: widget._theme.mainColor,
      ),
      body: Center(
        child: ListView(
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Card(
              elevation: 8.0,
              child: ListTile(
                leading: Icon(
                  Icons.directions_car,
                  color: _carColor,
                ),
                title: Text('$_brand $_name'),
                subtitle: Text('${_yearController.text}'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _brandController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Brand',
                    ),
                    onChanged: (str) {
                      setState(() {
                        _brand = str;
                      });
                    },
                  ),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                    onChanged: (str) {
                      setState(() {
                        _name = str;
                      });
                    },
                  ),
                  TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Year',
                    ),
                    onChanged: (str) {
                      setState(() {
                        _year = str;
                      });
                    },
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Pick color'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
              textColor: widget._theme.textColor,
              onPressed: () {
                displayDialog();
              },
            ),
            RaisedButton(
              child: Text('Done'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
              textColor: widget._theme.textColor,
              onPressed: () {
                if (_dataIsValid()) {
                  addCar(Car(_brandController.text, _nameController.text,
                      _yearController.text, _carColor));

                  Navigator.pop(context);
                  displayToast(widget._theme, 'Car was added!');

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
