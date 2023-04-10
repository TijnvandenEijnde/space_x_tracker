import 'package:flutter/material.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';

class StatusText extends StatelessWidget {
  final bool success;
  final bool upcoming;

  const StatusText({
    Key? key,
    required this.success,
    required this.upcoming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      success
          ? upcoming == true
              ? 'UPCOMING'
              : 'FAILED'
          : 'SUCCESS',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: success
            ? upcoming == true
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.success,
      ),
    );
  }
}
