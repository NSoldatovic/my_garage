import 'package:flutter/material.dart';
import 'package:my_garage/models/vehicle.dart';
import 'package:my_garage/utils/helper_widgets.dart';

import 'widgets/card_list.dart';
import 'widgets/menu_popup.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: Size(size.width * 0.12, size.width * 0.12)),
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed('/add_vehicle', arguments: {
          'vehicle': Vehicle(
              id: 'temp',
              model: 'model',
              brand: 'brand',
              year: 'year',
              description: 'description')
        }),
      ),
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Text(
          'My Garage',
          style: TextStyle(fontSize: 40),
        ),
        actions: [MenuPopup()],
      ), */
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 25, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(10),
                    const Text('My',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                    const Text('Garage',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40)),
                  ],
                ),
                MenuPopup()
              ],
            ),
          ),
          addVerticalSpace(8),
          Container(
            padding: EdgeInsets.only(left: 25),
            width: size.width * 0.7,
            child: const Divider(
              height: 3,
              thickness: 1.3,
            ),
          ),
          const Expanded(child: CardList()),
        ],
      ),
    ));
  }
}
