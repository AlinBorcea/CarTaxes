import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_taxes/app_strings.dart';
import 'package:car_taxes/car/car.dart';
import 'package:car_taxes/tax/tax.dart';

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

Future<void> addTax(String collectionName, Tax tax) async {
  Firestore.instance.collection(collectionName).document(tax.title).setData({
    titleVal: tax.title,
    descriptionVal: tax.description,
    dateVal: tax.date,
    timeVal: tax.time,
  }).catchError((e){
    print(e);
  });
}

Future<void> updateTax(String collectionName, Tax tax) async {
  Firestore.instance.collection(collectionName).document(tax.title)
      .updateData({
    titleVal: tax.title,
    descriptionVal: tax.description,
    dateVal: tax.date,
    timeVal: tax.time,
  });
}

deleteCar(String name) {
  Firestore.instance.collection(carCollectionName).document(name).delete();
  Firestore.instance.collection(name).getDocuments().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.documents)
      ds.reference.delete();
  });
}

/// The structure is:
/// 2 0 1 9 - 1 0 - 1 6 00:00:00.000
/// 0 1 2 3 4 5 6 7 8 9
getDate(String date) {
  return date.substring(0, 10);
}

/// The structure is:
/// T i m e O f D a y (  1  0  :  0  0  )
/// 0 1 2 3 4 5 6 7 8 9 10 11 12 13  14 15
getTime(String time) {
  return time.substring(10, time.length - 1);
}
