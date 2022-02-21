import 'package:flutter/material.dart';

import 'package:my_garage/utils/helper_widgets.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Description',
            style: TextStyle(fontFamily: 'SGotham', fontSize: 17)),
        addVerticalSpace(12),
        Text(description),
      ]),
    );
  }
}
