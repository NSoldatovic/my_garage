import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_garage/providers/theme_manager.dart';
import 'package:my_garage/screens/add_vehicle/add_vehicle.dart';
import 'package:my_garage/screens/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:is_first_run/is_first_run.dart';

import 'providers/list_of_vehicles.dart';
import 'screens/vehicle_details/vehicle_details_screen.dart';
import 'screens/vehicle_garage/garage.dart';
import 'utils/db_helper.dart';
import 'utils/theme_constants.dart';

void main() {
  FlutterNativeSplash.removeAfter(initialization);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
    ),
    ChangeNotifierProvider.value(
      value: VehicleList(),
    ),
  ], child: const MyApp()));
}

void initialization(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>>? data;
  Future? dataFuture;

  @override
  void initState() {
    print('NESTOOOO PRVOOO');

    dataFuture = _getData();
    super.initState();
  }

  Future<bool> _getData() async {
    print('STVARNO NE RAZUMEM');
    await _preLoadDB();
    data = await DBHelper.getData('user_vehicles');
    if (data.toString() != '[]') {
      //print(data);
      context.read<VehicleList>().fetchAndSetPlaces(data!);
    }
    print('kraj get data');
    return true;
  }

  Future<void> _preLoadDB() async {
    bool firstCall = await IsFirstRun.isFirstCall();
    if (firstCall) {
      print('Jeste PRVI RUNN DOBRO JE ZA SADa');
      DBHelper.insert('user_vehicles', {
        'id': '111111111',
        'year': '2020',
        'brand': 'BMW',
        'model': 'X3',
        'description': 'This is an example of a car in a garage',
        'imgUrl':
            'https://media.ed.edmunds-media.com/bmw/x3/2022/oem/2022_bmw_x3_4dr-suv_xdrive30i_fq_oem_1_1280.jpg',
        'transmission': 'Automatic',
        'mileage': '11000',
        'fuelType': 'Diesel',
        'engine': '339',
        'tires': 'All-season',
        'regDate': '2021-11-19 00:00:00.000',
        'fuel': 95,
        'isFav': 1,
        'image': 'null',
      });
      DBHelper.insert('user_vehicles', {
        'id': '2222222',
        'year': '2022',
        'brand': 'MERCEDES BENZ',
        'model': 'C CLASS',
        'description': 'This is an example of a car in a garage',
        'imgUrl':
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/2022-mercedes-benz-c-class-106-1613767205.jpg',
        'transmission': 'Automatic',
        'mileage': '56000',
        'fuelType': 'null',
        'engine': '339',
        'tires': 'null',
        'regDate': 'null',
        'fuel': 70,
        'isFav': 0,
        'image': 'null',
      });
      DBHelper.insert('user_vehicles', {
        'id': '3333333',
        'year': '2018',
        'brand': 'FORD',
        'model': 'MUSTANG GT',
        'description': 'This is an example of a car in a garage',
        'imgUrl':
            'https://www.tuningblog.eu/wp-content/uploads/2020/11/Pettys-Garage-Ford-Mustang-GT-Tuning-Warrior-Edition-12.jpg',
        'transmission': 'Manual',
        'mileage': '113000',
        'fuelType': 'Diesel',
        'engine': '339',
        'tires': 'Summer',
        'regDate': '2022-01-19 00:00:00.000',
        'fuel': 30,
        'isFav': 0,
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
        future: dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const AndroidAppDesign();
          } else {
            return const LoadingScreen();
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
