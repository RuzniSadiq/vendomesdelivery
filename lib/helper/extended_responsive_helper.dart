import 'package:flutter/cupertino.dart';

class ExtendedResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tab;
  final Widget tabextended;
  final Widget desktop;

  const ExtendedResponsiveWidget(
      {Key? key,
      required this.mobile,
      required this.tab,
        required this.tabextended,
      required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 640) {
        return mobile;
      } else if (constraints.maxWidth >= 641 && constraints.maxWidth <= 919) {
        return tab;
      } else if ((constraints.maxWidth >= 920 && constraints.maxWidth < 1250)) {
        return tabextended;
      } else if (constraints.maxWidth >= 1251) {
        return desktop;
      } else {
        return mobile;
      }
    });
  }
}
