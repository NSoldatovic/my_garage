import 'package:flutter/material.dart';

import 'package:my_garage/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_manager.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeManager>().themeMode;
    final isLight = theme == ThemeMode.light;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Description',
            style: const TextStyle(fontFamily: 'SGotham', fontSize: 17)),
        addVerticalSpace(12),
        Text(description),
      ]),
    );
  }
}
