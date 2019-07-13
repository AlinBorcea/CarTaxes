import 'package:flutter/material.dart';

class ListTax extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListTaxState();
}

class ListTaxState extends State<ListTax> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxes'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  Text('A tax'),
                  Text('Another tax'),
                  Text('Yet another tax'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
