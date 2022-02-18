import 'package:flutter/material.dart';
import 'package:my_garage/utils/helper_widgets.dart';
import 'package:provider/provider.dart';
import '../../../models/vehicle.dart';
import '../../../providers/theme_manager.dart';
import '../icons/details_icons.dart';

class Informations extends StatelessWidget {
  final Vehicle vehicle;
  const Informations({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;
    final color = theme == ThemeMode.light
        ? Color.fromARGB(255, 110, 110, 110)
        : Color.fromARGB(255, 218, 218, 218);

    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Informations',
              style: TextStyle(fontFamily: 'SGotham', fontSize: 17)),
          addVerticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Info(
                title: 'Year',
                icon: Icon(Details.schedule, color: color),
                value: vehicle.year,
              ),
              Info(
                title: 'Mileage',
                icon: Icon(Details.road, color: color),
                value: vehicle.mileage == null ? null : '${vehicle.mileage}km',
              ),
              Info(
                title: 'Fuel Type',
                icon: Icon(Details.biodiesel, color: color),
                value: vehicle.fuelType,
              ),
            ],
          ),
          addVerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Info(
                  title: 'Transmission',
                  icon: Icon(Details.transmission, color: color),
                  value: vehicle.transmission,
                  height: 0.04),
              Info(
                  title: 'Engine \nPower',
                  icon: Icon(Details.engine, color: color),
                  value: vehicle.engine == null ? null : '${vehicle.engine}kW',
                  height: 0.035),
              Info(
                title: 'Tires',
                icon: Icon(Details.tires, color: color),
                value: vehicle.tires,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  String title;
  String? value;
  final double height;
  Icon icon;

  Info(
      {Key? key,
      required this.title,
      required this.icon,
      this.value,
      this.height = 0.03})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeManager>().themeMode;
    final isLight = theme == ThemeMode.light;
    final size = MediaQuery.of(context).size;

    return Container(
      // padding: EdgeInsets.only(left: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.27,
            height: size.height * height,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: [
                  icon,
                  Text(
                    title,
                    style: TextStyle(
                        color: isLight
                            ? Color.fromARGB(255, 110, 110, 110)
                            : Color.fromARGB(255, 218, 218, 218)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.25,
            height: size.height * 0.023,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                value ??= '/',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
