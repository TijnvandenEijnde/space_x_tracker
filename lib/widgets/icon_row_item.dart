import 'package:flutter/material.dart';

class IconRowItem extends StatelessWidget {
  final int count;
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
          size: MediaQuery.of(context).size.width * 0.05,
        ),
        Text(count == 0 ? '0' : count.toString()),
      ],
    );
  }
}
