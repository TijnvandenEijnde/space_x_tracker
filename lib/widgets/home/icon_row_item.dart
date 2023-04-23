import 'package:flutter/material.dart';

class IconRowItem extends StatelessWidget {
  final String count;
  final IconData icon;

  const IconRowItem({
    Key? key,
    required this.count,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Row(
      children: [
        Icon(
          icon,
          size: orientation == Orientation.portrait ? size.width * 0.05 : 20,
        ),
        Text(count),
      ],
    );
  }
}
