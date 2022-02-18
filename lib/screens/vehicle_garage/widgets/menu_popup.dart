import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../providers/theme_manager.dart';

class MenuPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.settings,
        size: 45,
      ),
      itemBuilder: (ctx) => [
        PopupMenuItem(
            child: Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.dark_mode_outlined,
              size: 40,
              color: Colors.black,
            ),
          ),
          Column(
            children: [
              Text('Dark Mode'),
              Consumer<ThemeManager>(builder: (context, state, child) {
                return Switch(
                    value: state.themeMode == ThemeMode.dark,
                    onChanged: (newValue) => state.toggleTheme(newValue));
              }),
            ],
          )
        ]))
      ],
    );
  }
}
