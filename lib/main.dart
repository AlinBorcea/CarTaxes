import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'settings/settings.dart';
import 'tax/car_taxes.dart';
import 'car/add_car.dart';
import 'app_strings.dart';
import 'app_colors.dart';
import 'car/car.dart';

main() async {
  Color _appColor = await getCurrentColor();
  runApp(MaterialApp(
    title: 'Car taxes',
    theme: ThemeData(
      primarySwatch: _appColor,
    ),
    home: Cars(_appColor),
  ));
}

class Cars extends StatefulWidget {
  final Color _appColor;

  Cars(this._appColor);

  @override
  State createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chillWhite,
      appBar: AppBar(
        title: Text('Cars'),
        backgroundColor: widget._appColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
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
                                  widget._appColor))),
                      child: Card(
                        margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          enabled: true,
                          leading: Icon(
                            Icons.directions_car,
                            color: Color(_document[colorVal]),
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
            MaterialPageRoute(builder: (context) => AddCar(widget._appColor))),
        child: Icon(Icons.add),
      ),
    );
  }
}

/*
 */
