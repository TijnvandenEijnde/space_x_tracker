import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';

class TextRow extends StatelessWidget {
  final int? flightNumber;
  final String? name;
  final bool? success;

  const TextRow({
    Key? key,
    required this.flightNumber,
    required this.name,
    required this.success,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '#${flightNumber ?? '-'}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          name == null ? 'Unnamed' : name!.substring(0, min(name!.length, 10)),
        ),
        Text(
          // @todo success need nullcheck
          success == false ? 'FAILED' : 'SUCCESS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: success == false
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.success,
          ),
        ),
      ],
    );
  }
}
