import 'package:blurrycontainer/blurrycontainer.dart';
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
    final Function undoDelete = args['undo'];
    final size = MediaQuery.of(context).size;
    final theme = context.watch<ThemeManager>().themeMode;

    Future<void> _delete() async {
      var undo = false;
      context.read<VehicleList>().deleteFromList(vehicle.id);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Vehicle deleted from garage!'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            undo = true;
          },
        ),
      ));
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500));
      undoDelete(undo, vehicle.id);
    }

    double _calculateWidth(double length, bool isYear) {
      if (isYear) {
        return length * 16.5;
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

    void _showDialog() {
      showDialog(
          context: context,
          builder: (ctx) {
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
                    arguments: {'vehicle': vehicle, 'undo': undoDelete});
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
                            : vehicle.imgUrl != null
                                ? Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(vehicle.imgUrl!))
                                : Image.asset(
                                    'assets/images/noImg.jpg',
                                    fit: BoxFit.fill,
                                  ),
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
                            BlurryContainer(
                              blur: 12,
                              borderRadius: BorderRadius.circular(14),
                              padding: EdgeInsets.all(3),
                              width: _calculateWidth(
                                  vehicle.year.length.toDouble(), true),
                              height: 25,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(vehicle.year,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BlurryContainer(
                                          blur: 12,
                                          borderRadius:
                                              BorderRadius.circular(14),
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
                                            top: 4, left: 5, right: 5),
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
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: BorderIcon(
                        padding: EdgeInsets.all(0),
                        width: 45,
                        height: 45,
                        child: Favorite(
                          isFav: vehicle.isFav,
                          id: vehicle.id,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      Informations(vehicle: vehicle),
                      Cards(regDate: vehicle.regDate, fuel: vehicle.fuel),
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
      color: Colors.red,
      onPressed: _updateFav,
    );
  }
}
