import 'package:car_taxes/database/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'tax.dart';

class AddTax extends StatefulWidget {
  final String collectionName;

  AddTax(this.collectionName);

  @override
  State createState() => AddTaxState();
}

class AddTaxState extends State<AddTax> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add tax'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              controller: descriptionController,
            ),
            RaisedButton(
              child: Text('Choose date'),
              onPressed: () => selectDate(context),
            ),
            RaisedButton(
              child: Text('Choose time'),
              onPressed: () => selectTime(context),
            ),
            RaisedButton(
              child: Text('Add tax'),
              onPressed: () {
                addTax(widget.collectionName, Tax(titleController.text, descriptionController.text, date, time));
                titleController.text = '';
                descriptionController.text = '';
                date = null;
                time = null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> selectDate(BuildContext context) async {
    if (date == null)
      date = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
    );
    setState(() {
      date = picked;
    });
  }

  Future<Null> selectTime(BuildContext context) async {
    if (time == null)
      time = TimeOfDay.now();

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    setState(() {
      time = picked;
    });
  }
}
