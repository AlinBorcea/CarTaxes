import 'package:flutter/material.dart';

class AddTax extends StatefulWidget {

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
      appBar: AppBar(title: Text('Add tax'), backgroundColor: Colors.blue,),
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
                titleController.text = '';
                descriptionController.text = '';
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> selectDate(BuildContext context) async {
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
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    setState(() {
      time = picked;
    });
  }

}