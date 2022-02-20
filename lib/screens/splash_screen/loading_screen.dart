import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            extendBodyBehindAppBar: true,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            )));
  }
}
