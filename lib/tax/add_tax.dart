import 'package:car_taxes/database/firestore_helper.dart';
import 'package:car_taxes/app_colors.dart';
import 'package:flutter/material.dart';
import 'tax.dart';

class AddTax extends StatefulWidget {
  AddTax(this._collectionName, this._appColor);

  final String _collectionName;
  final Color _appColor;

  @override
  State createState() => AddTaxState();
}

class AddTaxState extends State<AddTax> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chillWhite,
      appBar: AppBar(
        title: Text('Add tax'),
        backgroundColor: widget._appColor,
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
              color: widget._appColor,
              onPressed: () => selectDate(context),
            ),
            RaisedButton(
              child: Text('Time: ${getTime(_time.toString())}'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._appColor,
              onPressed: () => selectTime(context),
            ),
            RaisedButton(
              child: Text('Add tax'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: widget._appColor,
              onPressed: () {
                addTax(widget._collectionName, Tax(_titleController.text, _descriptionController.text, _date, _time));
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
