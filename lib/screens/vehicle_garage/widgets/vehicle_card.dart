import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_garage/models/vehicle.dart';
import 'package:my_garage/providers/list_of_vehicles.dart';
import 'package:my_garage/utils/helper_widgets.dart';
import 'package:provider/provider.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

import '../../../providers/theme_manager.dart';

class VehicleCard extends StatelessWidget {
  final Function undoDelete;
  Vehicle vehicle;
  VehicleCard({Key? key, required this.vehicle, required this.undoDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _calculateWidth(double length, bool isYear) {
      if (isYear) {
        return length * 14.4;
      } else {
        String temp = '';
        if (vehicle.brand.length + vehicle.model.length < 15) {
          temp = '${vehicle.brand} ${vehicle.model}';
        } else {
          temp = length == vehicle.brand.length.toDouble()
              ? vehicle.brand
              : vehicle.model;
        }
        length = 0;
        print(temp);
        for (int i = 0; i < temp.length; i++) {
          if (temp[i] == ' ') {
            length += 0.37;
          } else {
            if (temp[i] == '-') {
              print('ALOOOO BRE');
              length += 0.5;
            } else {
              print(length);
              length++;
            }
          }
          if (temp[i] == 'W') {
            length += 0.8;
          }
        }
        print(length);
        return length * 16.1;
      }
    }

    void _updateFav() {
      context.read<VehicleList>().updateFav(vehicle.id, vehicle.isFav);
      //Navigator.of(context).pop();
    }

    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/vehicle_details',
              arguments: {'vehicle': vehicle, 'undo': undoDelete});
        },
        child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: SizedBox(
                        height: size.width * 0.55,
                        width: size.width - 40,
                        child: Hero(
                          tag: vehicle.id,
                          child: vehicle.image != null
                              ? Image.file(
                                  vehicle.image!,
                                  fit: BoxFit.fill,
                                )
                              : vehicle.imgUrl != null
                                  ? Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(vehicle.imgUrl!))
                                  : Image.asset(
                                      'assets/images/noImg.jpg',
                                      fit: BoxFit.fill,
                                    ),
                        ),
                      )),
                  Positioned(
                      bottom: 5,
                      right: 20,
                      child: IconButton(
                        icon: vehicle.isFav
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border_rounded),
                        color: Colors.white,
                        onPressed: _updateFav,
                      )),
                  Positioned(
                      bottom: 7,
                      left: 17,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlurryContainer(
                            blur: 12,
                            borderRadius: BorderRadius.circular(14),
                            padding: EdgeInsets.all(4),
                            width: _calculateWidth(
                                vehicle.year.length.toDouble(), true),
                            height: 25,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(vehicle.year,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      /* backgroundColor:
                                          Color.fromARGB(255, 50, 51, 51), */
                                      color: theme == ThemeMode.light
                                          ? Color.fromARGB(255, 112, 181, 190)
                                          : Color.fromARGB(
                                              255, 126, 138, 241))),
                            ),
                          ),
                          vehicle.brand.length + vehicle.model.length < 15
                              ? BlurryContainer(
                                  blur: 12,
                                  borderRadius: BorderRadius.circular(14),
                                  padding: EdgeInsets.all(5),
                                  width: _calculateWidth(
                                      (vehicle.brand.length +
                                              vehicle.model.length)
                                          .toDouble(),
                                      false),
                                  height: 29,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                        '${vehicle.brand} ${vehicle.model}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white)),
                                  ))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlurryContainer(
                                        blur: 12,
                                        borderRadius: BorderRadius.circular(14),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 5, right: 5),
                                        height: 25,
                                        width: _calculateWidth(
                                            vehicle.brand.length.toDouble(),
                                            false),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(vehicle.brand,
                                              style: const TextStyle(
                                                  leadingDistribution:
                                                      TextLeadingDistribution
                                                          .proportional,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        )),
                                    BlurryContainer(
                                      blur: 12,
                                      borderRadius: BorderRadius.circular(14),
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5, right: 5),
                                      height: 25,
                                      width: _calculateWidth(
                                          vehicle.model.length.toDouble(),
                                          false),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(vehicle.model,
                                            style: const TextStyle(
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .proportional,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      )),
                ],
              ),
            ])));
  }
}
