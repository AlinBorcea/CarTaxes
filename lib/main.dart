import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'tax/car_taxes.dart';
import 'car/add_car.dart';
import 'app_strings.dart';
import 'car/car.dart';

main() => runApp(Cars());

class Cars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car taxes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarsPage(title: 'Cars'),
      routes: <String, WidgetBuilder>{
        '/AddCar': (BuildContext context) => AddCar(),
      },
    );
  }
}

class CarsPage extends StatefulWidget {
  CarsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection(carCollectionName).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error ${snapshot.error}');

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');

              default:
                return ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarTaxes(Car(document.data[brandVal], document.data[nameVal], document.data[yearVal], Color(document.data[colorVal]))))),
                      child: Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          enabled: true,
                          leading: Icon(
                            Icons.directions_car,
                            color: Color(document[colorVal]),
                          ),
                          title: Text(
                              '${document[brandVal]} ${document[nameVal]}'),
                          subtitle: Text(document[yearVal]),
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
        onPressed: () => Navigator.of(context).pushNamed('/AddCar'),
        child: Icon(Icons.add),
      ),
    );
  }
}
