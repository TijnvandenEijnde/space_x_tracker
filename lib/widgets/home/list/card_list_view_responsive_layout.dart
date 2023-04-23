import 'package:flutter/material.dart';

class CardListViewResponsiveLayout extends StatelessWidget {
  final Widget smallLandscape;
  final Widget smallPortrait;
  final Widget mediumLandscape;
  final Widget mediumPortrait;
  final Widget large;

  const CardListViewResponsiveLayout({
    Key? key,
    required this.smallLandscape,
    required this.smallPortrait,
    required this.mediumLandscape,
    required this.mediumPortrait,
    required this.large,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return isPortrait ? smallPortrait : smallLandscape;
      }

      if (constraints.maxWidth > 800 && constraints.maxWidth < 1300) {
        return isPortrait ? mediumPortrait : mediumLandscape;
      }

      return large;
    });
  }
}
