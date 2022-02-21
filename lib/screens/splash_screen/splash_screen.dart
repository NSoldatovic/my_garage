import 'package:flutter/material.dart';

class SpashScreen extends StatelessWidget {
  const SpashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50),
                        ),
                        const Text(
                          'Garage',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 60),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(
                              width: 150,
                            ),
                            Text(
                              '2022',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal, fontSize: 19),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'made by',
                          style: TextStyle(
                              fontFamily: 'SGotham',
                              fontStyle: FontStyle.italic,
                              fontSize: 17),
                        ),
                        Text(
                          'Nikola Soldatovic',
                          style: TextStyle(fontFamily: 'SGotham', fontSize: 20),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}
