import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:car_taxes/database/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'car.dart';

class AddCar extends StatefulWidget {
  @override
  State createState() => AddCarState();
}

class AddCarState extends State<AddCar> {

  final TextEditingController brandController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  Color carColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add car'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView(
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextField(
              controller: brandController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Brand',
              ),
            ),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Year',
              ),
            ),
            MaterialColorPicker(
              onColorChange: (Color color) {
                setState(() {
                  carColor = color;
                  print(carColor.hashCode);
                });
              },
            ),
            RaisedButton(
              child: Text('Save car'),
              onPressed: () {
                addCar(Car(brandController.text, nameController.text,
                    yearController.text, carColor));
              },
            ),
          ],
        ),
      ),
    );
  }

}
