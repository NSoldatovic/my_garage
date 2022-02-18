import 'dart:io';

class Vehicle {
  final String id;
  final String model, brand, year, description;
  File? image;
  bool isFav;
  DateTime? regDate;
  int fuel;
  String? transmission, engine, tires, mileage, fuelType, imgUrl;

  Vehicle({
    required this.id,
    required this.model,
    required this.brand,
    required this.year,
    required this.description,
    this.transmission,
    this.engine,
    this.fuelType,
    this.imgUrl,
    this.mileage,
    this.tires,
    this.regDate,
    this.fuel = -1,
    this.isFav = false,
    this.image,
  });
}
