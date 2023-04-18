import 'package:flutter/material.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';
import 'package:space_x_tracker/providers/models/rocket.dart';

class RocketInformationBar extends StatelessWidget {
  final Rocket? rocket;

  const RocketInformationBar({
    Key? key,
    required this.rocket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    Map<IconData, Color> statusColors = {
      Icons.cancel: colorScheme.error,
      Icons.check_circle: colorScheme.success,
      Icons.help: colorScheme.tertiary,
    };

    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: size.width * 0.9,
        height: 80,
        decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 75,
                  color: colorScheme.shadow.withOpacity(0.2))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  rocket?.status ?? Icons.help,
                  size: 28,
                  color: statusColors[rocket?.status] ?? colorScheme.tertiary,
                ), //check_circle
                Text(rocket?.statusText ?? 'Unknown',
                    style: textTheme.labelLarge),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${rocket?.successRatePct.toString()}%' ?? 'Unknown',
                  style: textTheme.titleLarge,
                ),
                Text('Success rate',
                    style: textTheme.labelLarge),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rocket?.launchPrice ?? 'Unknown',
                  style: textTheme.titleLarge,
                ),
                Text('Launch cost',
                    style: textTheme.labelLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
