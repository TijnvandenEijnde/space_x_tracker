import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final String status;
  final Color color;

  const StatusText({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
