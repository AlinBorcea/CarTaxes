import 'package:car_taxes/database/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_taxes/extra/app_strings.dart';
import 'package:car_taxes/extra/app_strings.dart';
import 'package:car_taxes/extra/app_colors.dart';
import 'package:car_taxes/car/car_editor.dart';
import 'package:car_taxes/car/car.dart';
import 'package:flutter/material.dart';
import 'tax_editor.dart';
import 'tax.dart';

class CarTaxes extends StatefulWidget {
  CarTaxes(this._car, this._theme);

  final Car _car;
  final AppTheme _theme;

  @override
  State createState() => CarTaxesState();
}

class CarTaxesState extends State<CarTaxes> {
  Future<void> displayDeleteAlertDialog(BuildContext context) {
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
                  deleteCar(widget._car.name);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> displayTaxMenu(BuildContext context, Tax tax) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            title: Text('${tax.title}'),
            actions: <Widget>[
              FlatButton(
                child: Text('View'),
                textColor: widget._theme.mainColor,
                onPressed: () {

                },
              ),
              FlatButton(
                child: Text('Edit'),
                textColor: widget._theme.mainColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return EditTax(widget._car.name, 'Edit tax', widget._theme, tax);
                  }));
                },
              ),
              FlatButton(
                child: Text('Exit'),
                textColor: widget._theme.mainColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._theme.background,
      appBar: AppBar(
        title: Text('Taxes for ${widget._car.brand} ${widget._car.name}'),
        backgroundColor: widget._theme.mainColor,
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.delete_forever, color: widget._theme.textColor,),
            onPressed: () {
              displayDeleteAlertDialog(context);
            },
          ),
          FlatButton(
            child: Icon(Icons.edit, color: widget._theme.textColor,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditCar(widget._theme, widget._car);
              }));
            },
          ),
        ],
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
                      onTap: () {
                        displayTaxMenu(context, Tax(document[titleVal],
                            document[descriptionVal],
                            document[dateVal], document[titleVal], Color(document[taxColorVal])));
                      },
                      child: Card(
                        margin: EdgeInsets.all(4.00),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: ListTile(
                          leading: Image(image: AssetImage('images/tax-icon-15.png'), color: Color(document[taxColorVal])),
                          title: Text('${document.data[titleVal]}', textScaleFactor: 1.5,),
                          subtitle: Text('${document.data[timeVal]} on ${document.data[dateVal]}',
                          textScaleFactor: 1.5,),
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
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditTax(
                          widget._car.name, 'Add tax', widget._theme, null)),
            ),
      ),
    );
  }
}
