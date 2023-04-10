import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRow extends StatelessWidget {
  final DateTime? date;

  const DateRow({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          date == null
              ? 'No date'
              : DateFormat('MMM d y, h:mm:ss a').format(date!),
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
