import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_taxes/app_strings.dart';
import 'package:car_taxes/app_colors.dart';
import 'package:car_taxes/car/car.dart';
import 'package:flutter/material.dart';
import 'add_tax.dart';

class CarTaxes extends StatefulWidget {
  CarTaxes(this._car,this._appColor);

  final Car _car;
  final Color _appColor;

  @override
  State createState() => CarTaxesState();
}

class CarTaxesState extends State<CarTaxes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chillWhite,
      appBar: AppBar(
        title: Text('Taxes for ${widget._car.brand} ${widget._car.name}'),
        backgroundColor: widget._appColor,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection(widget._car.name).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');

              default:
                return ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return GestureDetector(
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.monetization_on,
                              size: 64.0,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  '${document[titleVal]}',
                                  textScaleFactor: 1.75,
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                    '${document[dateVal]}\n${document[timeVal]}',
                                    textScaleFactor: 1.5,
                                    textAlign: TextAlign.start),
                                Text('${document[descriptionVal]}',
                                    textScaleFactor: 1.25,
                                    textAlign: TextAlign.start),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddTax(widget._car.name, widget._appColor)),
        ),
      ),
    );
  }
}
