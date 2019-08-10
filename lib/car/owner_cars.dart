import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_taxes/extra/app_colors.dart';
import 'package:car_taxes/settings/settings.dart';
import 'package:car_taxes/extra/app_strings.dart';
import 'package:car_taxes/tax/car_taxes.dart';
import 'car_editor.dart';
import 'car.dart';

class Cars extends StatefulWidget {
  final AppTheme _theme;

  Cars(this._theme);

  @override
  State createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._theme.background,
      appBar: AppBar(
        title: Text('Cars'),
        backgroundColor: widget._theme.mainColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.color_lens, color: widget._theme.background,),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings(widget._theme)));
            },
          )
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection(carCollectionName).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> _snapshot) {
            if (_snapshot.hasError) return Text('Error ${_snapshot.error}');

            switch (_snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');

              default:
                return ListView(
                  children: _snapshot.data.documents
                      .map((DocumentSnapshot _document) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarTaxes(
                                  Car(
                                      _document.data[brandVal],
                                      _document.data[nameVal],
                                      _document.data[yearVal],
                                      Color(_document.data[colorVal])),
                                  widget._theme))),
                      child: Card(
                        margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          enabled: true,
                          leading: Image(
                            image: AssetImage('images/Passat.png'),
                          ),
                          title: Text(
                              '${_document[brandVal]} ${_document[nameVal]}'),
                          subtitle: Text(_document[yearVal]),
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
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddCar(widget._theme))),
        child: Icon(Icons.add),
      ),
    );
  }
}