import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:car_taxes/database/firestore_helper.dart';
import 'package:car_taxes/app_colors.dart';
import 'package:flutter/material.dart';
import 'car.dart';

class AddCar extends StatefulWidget {
  AddCar(this._appColor);

  final Color _appColor;

  @override
  State createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  Color _carColor = Colors.blue;

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
                  _carColor = color;
              },
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chillWhite,
      appBar: AppBar(
        title: Text('Add car'),
        backgroundColor: widget._appColor,
      ),
      body: Center(
        child: ListView(
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextField(
              controller: _brandController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Brand',
              ),
            ),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Year',
              ),
            ),
            RaisedButton(
              child: Text('Pick color'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._appColor,
              textColor: Colors.white,
              onPressed: () {
                displayDialog();
              },
            ),
            RaisedButton(
              child: Text('Save car'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._appColor,
              textColor: Colors.white,
              onPressed: () {
                addCar(Car(_brandController.text, _nameController.text,
                    _yearController.text, _carColor));
                _brandController.text = '';
                _nameController.text = '';
                _yearController.text = '';
                _carColor = Colors.blue;
              },
            ),
          ],
        ),
      ),
    );
  }

}
