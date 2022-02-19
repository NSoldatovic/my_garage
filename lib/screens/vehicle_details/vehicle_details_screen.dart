import 'package:flutter/material.dart';
import 'package:my_garage/utils/helper_widgets.dart';
import 'package:provider/provider.dart';
import '../../models/vehicle.dart';
import '../../providers/list_of_vehicles.dart';

import '../../providers/theme_manager.dart';
import 'widgets/border_icon.dart';
import 'widgets/description.dart';
import 'widgets/cards.dart';
import 'widgets/informations.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Vehicle vehicle = args['vehicle'];
    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;

    void _delete() {
      context.read<VehicleList>().deleteVehicle(vehicle.id);
      Navigator.of(context).pop();
    }

    void _updateFav() {
      context.read<VehicleList>().updateFav(vehicle.id, vehicle.isFav);
    }

    void _showDialog() {
      print('object');
      showDialog(
          context: context,
          builder: (ctx) {
            print('kao');
            return AlertDialog(
              elevation: 24,
              title: Text('Delete Vehicle'),
              content: Text('Are you sure you want to delete this vehicle?'),
              actions: [
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: theme == ThemeMode.dark ? Colors.white : null),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        color: theme == ThemeMode.dark ? Colors.white : null),
                  ),
                  onPressed: () {
                    _delete();

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    return SafeArea(
        child: Scaffold(
            floatingActionButton: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined),
                    Text(
                      '  Edit Vehicle',
                      style: TextStyle(fontSize: 19),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/add_vehicle',
                    arguments: vehicle);
              },
            ),
            /*  appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () => _showDialog(), icon: Icon(Icons.delete))
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ), */
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.3,
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
                    ),
                    Positioned(
                        width: size.width,
                        top: 15,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: const BorderIcon(
                                        height: 45,
                                        width: 45,
                                        child: Icon(
                                          Icons.arrow_back_rounded,
                                          color: Colors.black,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () => _showDialog(),
                                    child: const BorderIcon(
                                      height: 45,
                                      width: 45,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ]))),
                    Positioned(
                        bottom: 20,
                        left: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.year,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: theme == ThemeMode.light
                                      ? Color.fromARGB(255, 112, 181, 190)
                                      : Color.fromARGB(255, 126, 138, 241)),
                            ),
                            addVerticalSpace(5),
                            Text('${vehicle.brand} ${vehicle.model}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white))
                          ],
                        )),
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: Favorite(
                        isFav: vehicle.isFav,
                        id: vehicle.id,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      Informations(vehicle: vehicle),
                      Cards(),
                      Description(description: vehicle.description),
                      SizedBox(
                        height: size.height * 0.06,
                      )
                    ]),
                  ),
                )
              ],
            )));
  }
}

class Favorite extends StatefulWidget {
  Favorite({Key? key, required this.isFav, required this.id}) : super(key: key);

  bool isFav;
  final String id;

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    void _updateFav() {
      setState(() {
        context.read<VehicleList>().updateFav(widget.id, widget.isFav);
        widget.isFav = !widget.isFav;
      });
    }

    return IconButton(
      icon: widget.isFav
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border_rounded),
      color: Colors.white,
      onPressed: _updateFav,
    );
  }
}
