import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/list_of_vehicles.dart';

import 'vehicle_card.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleList = context.watch<VehicleList>().items;
    List favList = [];
    for (int i = 0; i < vehicleList.length; i++) {
      if (vehicleList[i].isFav) {
        favList.add(vehicleList[i]);
      }
    }
    return vehicleList.isEmpty
        ? const NoVehicleAdded()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              favList.isNotEmpty
                  ? Container(
                      padding:
                          const EdgeInsets.only(left: 27, top: 20, bottom: 5),
                      alignment: Alignment.bottomLeft,
                      child: const Text('Favorites',
                          style:
                              TextStyle(fontFamily: 'SGotham', fontSize: 17)))
                  : const SizedBox(),
              favList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: favList.length,
                          itemBuilder: (context, index) {
                            return VehicleCard(vehicle: favList[index]);
                          }),
                    )
                  : const SizedBox(),
              Container(
                  padding: const EdgeInsets.only(left: 27, top: 20, bottom: 5),
                  alignment: Alignment.bottomLeft,
                  child: vehicleList.length != favList.length
                      ? const Text('All',
                          style: TextStyle(fontFamily: 'SGotham', fontSize: 17))
                      : const SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: vehicleList.length,
                    itemBuilder: (context, index) {
                      if (!vehicleList[index].isFav) {
                        return VehicleCard(vehicle: vehicleList[index]);
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
            ]),
          );
  }
}

class NoVehicleAdded extends StatelessWidget {
  const NoVehicleAdded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('No vehicles were added to the garage.'),
        Text('Start adding them!')
      ],
    ));
  }
}
