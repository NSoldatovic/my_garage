import 'package:flutter/material.dart';
import 'package:my_garage/providers/theme_manager.dart';
import 'package:my_garage/screens/add_vehicle/add_vehicle.dart';
import 'package:my_garage/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:is_first_run/is_first_run.dart';

import 'providers/list_of_vehicles.dart';
import 'screens/vehicle_details/vehicle_details_screen.dart';
import 'screens/vehicle_garage/garage.dart';
import 'utils/db_helper.dart';
import 'utils/theme_constants.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
    ),
    ChangeNotifierProvider.value(
      value: VehicleList(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>>? data;
  bool _isInit = true;

  @override
  void initState() {
    print('NESTOOOO PRVOOO');

    _getData();
    super.initState();
  }

  /* @override
  void didChangeDependencies() {
    if (_isInit) {
      print('DID RADI');
      _getData();
    }

    _isInit = false;
    super.didChangeDependencies();
  } */

  Future<void> _getData() async {
    print('STVARNO NE RAZUMEM');
    await _preLoadDB();
    data = await DBHelper.getData('user_vehicles');
    if (data.toString() != '[]') {
      //print(data);
      context.read<VehicleList>().fetchAndSetPlaces(data!);
    }
  }

  Future<void> _preLoadDB() async {
    bool firstCall = await IsFirstRun.isFirstCall();
    if (firstCall) {
      print('Jeste PRVI RUNN DOBRO JE ZA SADa');
      DBHelper.insert('user_vehicles', {
        'id': '111111111',
        'year': '2018',
        'brand': 'BMW',
        'model': 'X3',
        'description': 'Ovaj auto je namenjen da se vozim brzo',
        'imgUrl':
            'https://images.pexels.com/photos/62693/pexels-photo-62693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500.jpg',
        'transmission': 'Automatic',
        'mileage': '113000',
        'fuelType': 'null',
        'engine': '1110',
        'tires': 'null',
        'regDate': 'null',
        'fuel': 95,
        'isFav': 1,
        'image': 'null',
      });
      DBHelper.insert('user_vehicles', {
        'id': '2222222',
        'year': '2018',
        'brand': 'BMW',
        'model': 'X3',
        'description': 'Ovaj auto je namenjen da se vozim brzo',
        'imgUrl':
            'https://images.pexels.com/photos/62693/pexels-photo-62693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500.jpg',
        'transmission': 'Automatic',
        'mileage': '113000',
        'fuelType': 'null',
        'engine': '1110',
        'tires': 'null',
        'regDate': 'null',
        'fuel': 95,
        'isFav': 1,
        'image': 'null',
      });
      DBHelper.insert('user_vehicles', {
        'id': '3333333',
        'year': '2018',
        'brand': 'BMW',
        'model': 'X3',
        'description': 'Ovaj auto je namenjen da se vozim brzo',
        'imgUrl':
            'https://images.pexels.com/photos/62693/pexels-photo-62693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500.jpg',
        'transmission': 'Automatic',
        'mileage': '113000',
        'fuelType': 'null',
        'engine': '1110',
        'tires': 'null',
        'regDate': 'null',
        'fuel': 95,
        'isFav': 1,
        'image': 'null',
      });
    } else {
      print('Neki drugi put');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Pali app');

    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const AndroidAppDesign();
          } else {
            return const SpashScreen();
          }
        });
  }
}

class AndroidAppDesign extends StatelessWidget {
  const AndroidAppDesign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.watch<ThemeManager>().themeMode,
      initialRoute: '/vehicle_overview',
      routes: {
        '/vehicle_overview': (ctx) => const OverviewScreen(),
        '/vehicle_details': (ctx) => const DetailsScreen(),
        '/add_vehicle': (ctx) => const AddVehicle(),
      },
    );
  }
}
