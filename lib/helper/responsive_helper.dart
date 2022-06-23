import 'package:flutter/cupertino.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tab;
  final Widget desktop;

  const ResponsiveWidget(
      {Key? key,
      required this.mobile,
      required this.tab,
      required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 640) {
        return mobile;
      } else if (constraints.maxWidth >= 641 && constraints.maxWidth <= 1007) {
        return tab;
      } else if (constraints.maxWidth >= 1008) {
        return desktop;
      } else {
        return mobile;
      }
    });
  }
}
