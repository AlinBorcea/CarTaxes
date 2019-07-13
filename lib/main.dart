import 'package:flutter/material.dart';
import 'car/add_car.dart';
import 'data.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: carList.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/ListTax');
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.local_car_wash,
                    color: carList[index].color,
                    size: 64.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '${carList[index].brand} ${carList[index].name}',
                        textAlign: TextAlign.start,
                        textScaleFactor: 2.0,
                      ),
                      Text(
                        '${carList[index].year}',
                        textAlign: TextAlign.start,
                        textScaleFactor: 2.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/AddCar'),
        child: Icon(Icons.add),
      ),
    );
  }
}
