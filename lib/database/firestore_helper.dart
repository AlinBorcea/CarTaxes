import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_taxes/car/car.dart';

final String carCollectionName = 'Cars';

Future<void> addCar(Car car) async {
  Firestore.instance
      .collection(carCollectionName)
      .document(car.name)
      .setData({
    'name': car.name,
    'brand': car.brand,
    'year': car.year,
    'color': car.color.toString()
  }).catchError((e) {
    print(e);
  });
}