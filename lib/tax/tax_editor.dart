import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:car_taxes/database/firestore_helper.dart';
import 'package:car_taxes/extra/app_colors.dart';
import 'package:car_taxes/car/car.dart';
import 'package:flutter/material.dart';
import 'tax.dart';

class EditTax extends StatefulWidget {
  EditTax(this._collectionName, this._appBarTitle, this._theme, this._tax);

  final String _collectionName;
  final String _appBarTitle;
  final AppTheme _theme;
  final Tax _tax;

  @override
  State createState() => EditTaxState();
}

class EditTaxState extends State<EditTax> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  String _title = '';
  String _descr = '';
  String _dateStr = '';
  String _timeStr = '';
  String _on = '';
  Color _color = Colors.blue;

  @override
  void initState() {
    super.initState();

    if (widget._tax != null) {
      _titleController.text = widget._tax.title;
      _descriptionController.text = widget._tax.description;
    }
  }

  Future<void> _displayDialog() async {
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
              selectedColor: _color,
              onColorChange: (Color color) {
                setState(() {
                  _color = color;
                });
              },
            ),
          );
        });
  }

  Future<void> _displayDeleteAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure you want to delete this car?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  deleteTax(widget._collectionName, widget._tax.title);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._theme.background,
      appBar: AppBar(
        title: Text(widget._appBarTitle),
        backgroundColor: widget._theme.mainColor,
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.delete),
            onPressed: () {
              _displayDeleteAlertDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8.00),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              child: ListTile(
                leading: Image(
                  image: AssetImage('images/tax-icon-15.png'),
                  color: _color,
                ),
                title: Text(_title, textScaleFactor: 1.5,),
                subtitle: Text('$_descr\n$_timeStr $_on $_dateStr',
                  textScaleFactor: 1.5,),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              controller: _titleController,
              onChanged: (str) {
                setState(() {
                  _title = str;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              controller: _descriptionController,
              onChanged: (str) {
                setState(() {
                  _descr = str;
                });
              },
            ),
            RaisedButton(
              child: Text('Time: ${getTime(_time.toString())}'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
              textColor: widget._theme.textColor,
              onPressed: () => selectTime(context),
            ),
            RaisedButton(
              child: Text('Date: ${getDate(_date.toString())}'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
              textColor: widget._theme.textColor,
              onPressed: () => selectDate(context),
            ),
            RaisedButton(
              child: Text('Pick color'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
                textColor: widget._theme.textColor,
              onPressed: () {
                _displayDialog();
              },
            ),
            RaisedButton(
              child: Text((widget._appBarTitle == 'Add tax' ? widget._appBarTitle : 'Update tax')),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
                textColor: widget._theme.textColor,
              onPressed: () {
                  if (widget._tax == null)
                    addTax(widget._collectionName,
                        Tax(_titleController.text, _descriptionController.text,
                            getDate(_date.toString()),
                            getTime(_time.toString()),
                            _color));
                  else {
                    debugPrint('Updating tax');
                    updateTax(widget._collectionName, widget._tax.title, Tax(
                        _titleController.text, _descriptionController.text,
                        getDate(_date.toString()), getTime(_time.toString()), _color));
                  }
                  Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> selectDate(BuildContext context) async {
    if (_date == null)
      _date = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
    );
    setState(() {
      _date = picked;
      _dateStr = getDate(_date.toString());
      _on = 'on';
    });
  }

  Future<Null> selectTime(BuildContext context) async {
    if (_time == null)
      _time = TimeOfDay.now();

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    setState(() {
      _time = picked;
      _timeStr = getTime(_time.toString());
    });
  }
}
