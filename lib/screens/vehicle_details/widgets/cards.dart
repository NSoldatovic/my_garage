import 'package:flutter/material.dart';
import 'package:my_garage/screens/vehicle_details/widgets/fuel.dart';
import 'package:my_garage/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_manager.dart';
import 'graph.dart';

class Cards extends StatelessWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Registration(),
            Fuel(),
            Avg(),
            LastService(),
          ],
        ),
      ),
    );
  }
}

class Fuel extends StatelessWidget {
  const Fuel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;
    final colorList = theme == ThemeMode.light
        ? [
            Colors.green,
            Colors.teal,
          ]
        : [
            Color.fromARGB(255, 20, 86, 161),
            Colors.indigo,
          ];
    return Container(
      margin: EdgeInsets.only(right: 20, bottom: 15),
      width: 140,
      height: 160,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme == ThemeMode.light
                  ? Colors.grey.withOpacity(0.5)
                  : Color.fromARGB(255, 63, 63, 63).withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 7,
              offset: const Offset(4, 8),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.9],
            colors: colorList,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Fuel',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Expanded(child: FuelMeter(value: 60))
          ],
        ),
      ),
    );
  }
}

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;
    final colorList = theme == ThemeMode.light
        ? [
            Colors.green,
            Colors.teal,
          ]
        : [
            Color.fromARGB(255, 20, 86, 161),
            Colors.indigo,
          ];
    return Container(
      margin: EdgeInsets.only(right: 20, bottom: 15),
      width: 140,
      height: 160,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme == ThemeMode.light
                  ? Colors.grey.withOpacity(0.5)
                  : Color.fromARGB(255, 63, 63, 63).withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 7,
              offset: const Offset(4, 8),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.9],
            colors: colorList,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Registration Expires In ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
            Text(
              '111',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                child: Text('Days',
                    style: TextStyle(fontSize: 20, color: Colors.white)))
          ],
        ),
      ),
    );
  }
}

class Avg extends StatelessWidget {
  const Avg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;
    final colorList = theme == ThemeMode.light
        ? [
            Colors.green,
            Colors.teal,
          ]
        : [
            Color.fromARGB(255, 20, 86, 161),
            Colors.indigo,
          ];
    return Container(
        margin: EdgeInsets.only(right: 20, bottom: 15),
        width: 140,
        height: 160,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: theme == ThemeMode.light
                    ? Colors.grey.withOpacity(0.5)
                    : Color.fromARGB(255, 63, 63, 63).withOpacity(0.5),
                spreadRadius: 0.2,
                blurRadius: 7,
                offset: const Offset(4, 8),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 0.9],
              colors: colorList,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Avrage Fuel',
                    style: TextStyle(
                        fontFamily: 'SGotham',
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  Text('Consumption',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                ],
              ),
            ),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: SizedBox(
                child: Graph(m1: 'J', m2: 'F'),
              ),
            ))
          ],
        ));
  }
}

class LastService extends StatelessWidget {
  const LastService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;
    final colorList = theme == ThemeMode.light
        ? [
            Colors.green,
            Colors.teal,
          ]
        : [
            Color.fromARGB(255, 20, 86, 161),
            Colors.indigo,
          ];
    return Container(
      margin: EdgeInsets.only(right: 20, bottom: 15),
      width: 140,
      height: 160,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme == ThemeMode.light
                  ? Colors.grey.withOpacity(0.5)
                  : Color.fromARGB(255, 63, 63, 63).withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 7,
              offset: const Offset(4, 8),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.9],
            colors: colorList,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '95',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Text('days',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      addVerticalSpace(10),
                    ],
                  )
                ],
              ),
              /* Text(
                "since",
                style: TextStyle(fontSize: 15),
              ), */
              Text(
                'Since Last Service',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )
            ],
          )),
    );
  }
}
