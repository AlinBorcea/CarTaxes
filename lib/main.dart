import 'package:flutter/material.dart';
import 'car/add_car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tax/list_taxes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car taxes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cars'),
      routes: <String, WidgetBuilder> {
        '/AddCar': (BuildContext context) => AddCar(),
        '/ListTax': (BuildContext context) => ListTax(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String carCollectionName = 'Cars';

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
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Text('Error ${snapshot.error}');

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');

              default:
                return ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    return ListTile(
                      title: Text('${document['brand']} ${document['name']}'),
                      subtitle: Text(document['year']),
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
