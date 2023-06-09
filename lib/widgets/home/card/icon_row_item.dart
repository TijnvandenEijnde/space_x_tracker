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
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        Text(count),
      ],
    );
  }
}
