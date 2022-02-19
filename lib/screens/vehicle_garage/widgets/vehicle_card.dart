import 'package:flutter/material.dart';
import 'package:my_garage/models/vehicle.dart';
import 'package:my_garage/providers/list_of_vehicles.dart';
import 'package:my_garage/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_manager.dart';

class VehicleCard extends StatelessWidget {
  Vehicle vehicle;
  VehicleCard({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _updateFav() {
      context.read<VehicleList>().updateFav(vehicle.id, vehicle.isFav);
      //Navigator.of(context).pop();
    }

    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed('/vehicle_details', arguments: {'vehicle': vehicle});
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
                      child: Container(
                        height: size.height * 0.23,
                        width: size.width - 40,
                        child: Hero(
                          tag: vehicle.id,
                          child: vehicle.image != null
                              ? Image.file(
                                  vehicle.image!,
                                  fit: BoxFit.fill,
                                )
                              : Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(vehicle.imgUrl ??
                                      'https://thumbs.dreamstime.com/b/illustration-hand-drawn-car-white-lines-black-background-abstract-art-objects-isolated-shape-design-auto-148327343.jpg')),
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
                      bottom: 15,
                      left: 25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(vehicle.year,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: theme == ThemeMode.light
                                      ? Color.fromARGB(255, 112, 181, 190)
                                      : Color.fromARGB(255, 126, 138, 241))),
                          addVerticalSpace(5),
                          Text('${vehicle.brand} ${vehicle.model}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white))
                        ],
                      )),
                ],
              ),
            ])));
  }
}
