import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_taxes/car/car.dart';
import 'package:car_taxes/app_strings.dart';

Future<void> addCar(Car car) async {
  Firestore.instance.collection(carCollectionName).document(car.name).setData({
    brandVal: car.brand,
    nameVal: car.name,
    yearVal: car.year,
    colorVal: car.color.hashCode
  }).catchError((e) {
    print(e);
  });
}
