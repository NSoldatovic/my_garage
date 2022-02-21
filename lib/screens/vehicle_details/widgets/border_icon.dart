import 'package:flutter/material.dart';

class BorderIcon extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double width, height;

  const BorderIcon(
      {Key? key,
      required this.child,
      this.padding,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(
                color: const Color.fromRGBO(141, 141, 141, 1.0).withAlpha(40),
                width: 2)),
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Center(child: child));
  }
}
