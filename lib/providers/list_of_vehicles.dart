import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

import '../models/vehicle.dart';
import '../utils/db_helper.dart';

class VehicleList with ChangeNotifier {
  List<Vehicle> _items = [];
  Vehicle? recoveryVehicle;
  int? recoveryIndex;

  List<Vehicle> get items {
    return [..._items];
  }

  Vehicle findById(String id) {
    print(_items);
    return _items.firstWhere((vehicle) => vehicle.id == id);
  }

  final DateFormat formatter = DateFormat('yyyyMMddHms');

  Future<void> addVehicle(Vehicle tempVehicle) async {
    final newVehicle = Vehicle(
      id: formatter.format(DateTime.now()),
      model: tempVehicle.model,
      brand: tempVehicle.brand,
      year: tempVehicle.year,
      description: tempVehicle.description,
      fuel: Random().nextInt(100),
      transmission: tempVehicle.transmission,
      engine: tempVehicle.engine,
      tires: tempVehicle.tires,
      regDate: tempVehicle.regDate,
      mileage: tempVehicle.mileage,
      fuelType: tempVehicle.fuelType,
      imgUrl: tempVehicle.imgUrl,
    );
    newVehicle.image = tempVehicle.image;

    _items.add(newVehicle);
    notifyListeners();
    final String temp =
        newVehicle.regDate == null ? 'null' : newVehicle.regDate.toString();
    print(temp);
    DBHelper.insert('user_vehicles', {
      'id': newVehicle.id,
      'year': newVehicle.year,
      'brand': newVehicle.brand,
      'model': newVehicle.model,
      'description': newVehicle.description,
      'imgUrl': newVehicle.imgUrl ?? 'null',
      'transmission': newVehicle.transmission ?? 'null',
      'mileage': newVehicle.mileage ?? 'null',
      'fuelType': newVehicle.fuelType ?? 'null',
      'engine': newVehicle.engine ?? 'null',
      'tires': newVehicle.tires ?? 'null',
      'regDate': temp,
      'fuel': newVehicle.fuel,
      'isFav': newVehicle.isFav ? 1 : 0,
      'image': newVehicle.image == null ? 'null' : newVehicle.image!.path,
    });
    print('Dodat auto');
  }

  void fetchAndSetPlaces(List<Map<String, dynamic>> dataList) {
    print('a1');

    print(dataList.length);
    _items = dataList
        .map(
          (item) => Vehicle(
            id: item['id'],
            year: item['year'],
            brand: item['brand'],
            model: item['model'],
            imgUrl: item['imgUrl'] == 'null' ? null : item['imgUrl'],
            transmission:
                item['transmission'] == 'null' ? null : item['transmission'],
            mileage: item['mileage'] == 'null' ? null : item['mileage'],
            fuelType: item['fuelType'] == 'null' ? null : item['fuelType'],
            engine: item['engine'] == 'null' ? null : item['engine'],
            tires: item['tires'] == 'null' ? null : item['tires'],
            regDate: item['regDate'] == 'null'
                ? null
                : DateTime.parse(item['regDate']),
            description: item['description'],
            fuel: item['fuel'],
            isFav: item['isFav'] == 1 ? true : false,
            image: item['image'] == 'null' ? null : File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
    print(_items[0].fuel);
    print('a2');

    print('fecand set');
  }

  Future<void> deleteVehicle(String id) async {
    await DBHelper.delete('user_vehicles', id);

    print('obrisi iz baze');
  }

  void deleteFromList(String id) {
    final index = _items.indexWhere((vehicle) => vehicle.id == id);
    recoveryVehicle = _items[index];
    recoveryIndex = index;

    _items.removeAt(index);
    notifyListeners();

    print('obrisi iz list');
  }

  void recoverToList() {
    _items.insert(
        recoveryIndex!,
        Vehicle(
            id: recoveryVehicle!.id,
            model: recoveryVehicle!.model,
            brand: recoveryVehicle!.brand,
            year: recoveryVehicle!.year,
            description: recoveryVehicle!.description,
            transmission: recoveryVehicle!.transmission,
            engine: recoveryVehicle!.engine,
            fuelType: recoveryVehicle!.fuelType,
            imgUrl: recoveryVehicle!.imgUrl,
            mileage: recoveryVehicle!.mileage,
            tires: recoveryVehicle!.tires,
            regDate: recoveryVehicle!.regDate,
            fuel: recoveryVehicle!.fuel,
            isFav: recoveryVehicle!.isFav,
            image: recoveryVehicle!.image));
    notifyListeners();

    print('vrati u listu');
  }

  Future<void> update(Vehicle editedVehicle) async {
    final index =
        _items.indexWhere((vehicle) => vehicle.id == editedVehicle.id);
    final backup = _items[index];
    _items[index] = Vehicle(
        id: editedVehicle.id,
        model: editedVehicle.model,
        brand: editedVehicle.brand,
        year: editedVehicle.year,
        description: editedVehicle.description,
        fuel: editedVehicle.fuel,
        isFav: editedVehicle.isFav,
        transmission: editedVehicle.transmission,
        tires: editedVehicle.tires,
        engine: editedVehicle.engine,
        mileage: editedVehicle.mileage,
        fuelType: editedVehicle.fuelType,
        imgUrl: editedVehicle.imgUrl,
        regDate: editedVehicle.regDate);
    _items[index].image = editedVehicle.image;
    notifyListeners();

    final String temp = editedVehicle.regDate == null
        ? 'null'
        : editedVehicle.regDate.toString();
    Map<String, Object> data = {
      'year': editedVehicle.year,
      'brand': editedVehicle.brand,
      'model': editedVehicle.model,
      'description': editedVehicle.description,
      'imgUrl': editedVehicle.imgUrl ?? 'null',
      'transmission': editedVehicle.transmission ?? 'null',
      'mileage': editedVehicle.mileage ?? 'null',
      'fuelType': editedVehicle.fuelType ?? 'null',
      'engine': editedVehicle.engine ?? 'null',
      'tires': editedVehicle.tires ?? 'null',
      'regDate': temp,
    };
    int code = await DBHelper.update('user_vehicles', data, editedVehicle.id);
    if (code < 1) {
      _items[index] = backup;
    }

    print('update');
  }

  Future<void> updateFav(String id, bool boolIsFav) async {
    boolIsFav = !boolIsFav;
    print(_items.lastWhere((element) => element.id == id).isFav);
    int isFav = boolIsFav ? 1 : 0;
    int code = await DBHelper.update('user_vehicles', {"isFav": isFav}, id);
    //final index = _items.indexWhere((vehicle) => vehicle.id == id);
    //print(code);
    if (code > 0) {
      _items.lastWhere((element) => element.id == id).isFav = boolIsFav;
      notifyListeners();
    }
    print(_items.lastWhere((element) => element.id == id).isFav);
    print('updateFav');
  }
}
