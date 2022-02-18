import 'package:flutter/material.dart';

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
            Fuel(),
            Fuel(),
            Fuel(),
            Fuel(),
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
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: size.width * 0.34,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red[500]!,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Text(
          '          registacija  \n gorivo \n avg fuel consumption\ndays since the last service'),
    );
  }
}
