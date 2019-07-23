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


  @override
  void initState() {
    super.initState();

    if (widget._tax != null) {
      _titleController.text = widget._tax.title;
      _descriptionController.text = widget._tax.description;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._theme.background,
      appBar: AppBar(
        title: Text(widget._appBarTitle),
        backgroundColor: widget._theme.mainColor,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              controller: _descriptionController,
            ),
            RaisedButton(
              child: Text('Date: ${getDate(_date.toString())}'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
              onPressed: () => selectDate(context),
            ),
            RaisedButton(
              child: Text('Time: ${getTime(_time.toString())}'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
              onPressed: () => selectTime(context),
            ),
            RaisedButton(
              child: Text((widget._appBarTitle == 'Add task' ? widget._appBarTitle : 'Update tax')),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._theme.mainColor,
              onPressed: () {

                if (widget._tax == null)
                  addTax(widget._collectionName,
                      Tax(_titleController.text, _descriptionController.text, getDate(_date.toString()), getTime(_time.toString())));
                else
                  updateTax(widget._collectionName, Tax(_titleController.text, _descriptionController.text, getDate(_date.toString()), getTime(_time.toString())));

                _titleController.text = '';
                _descriptionController.text = '';
                _date = null;
                _time = null;
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
    });
  }
}
