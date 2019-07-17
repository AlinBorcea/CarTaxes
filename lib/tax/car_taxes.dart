import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_taxes/app_strings.dart';
import 'package:car_taxes/car/car.dart';
import 'package:flutter/material.dart';
import 'add_tax.dart';

class CarTaxes extends StatefulWidget {
  final Car car;

  CarTaxes(this.car);

  @override
  State createState() => CarTaxesState();
}

class CarTaxesState extends State<CarTaxes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxes for ${widget.car.brand} ${widget.car.name}'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(widget.car.name).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');

                default:
                  return ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return GestureDetector(
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.monetization_on, size: 64.0,),
                              Column(
                                children: <Widget>[
                                  Text('${document[titleVal]}', textScaleFactor: 1.75, textAlign: TextAlign.left,),
                                  Text('${document[dateVal]}\n${document[timeVal]}', textScaleFactor: 1.5, textAlign: TextAlign.start),
                                  Text('${document[descriptionVal]}', textScaleFactor: 1.25, textAlign: TextAlign.start),
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
            MaterialPageRoute(builder: (context) => AddTax(widget.car.name)),
          ),
      ),
    );
  }
}
