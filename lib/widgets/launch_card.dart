import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/date_row.dart';
import 'package:space_x_tracker/widgets/icon_row.dart';
import 'package:space_x_tracker/widgets/patch.dart';
import 'package:space_x_tracker/widgets/text_row.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;

  const LaunchCard({Key? key, required this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<IconData, String> icons = {
      Icons.person: launch.crew?.length.toString() ?? '0',
      Icons.support: launch.cores?.length.toString() ?? '0',
      Icons.luggage: launch.payloads?.length.toString() ?? '0',
      Icons.directions_boat: launch.ships?.length.toString() ?? '0',
    };
    final List<Text> texts = [
      Text(
        '#${launch.flightNumber ?? '-'}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        launch.name == null
            ? 'Unnamed'
            : launch.name!.substring(0, min(launch.name!.length, 10)),
      ),
      Text(
        launch.success == null || launch.success == false ? 'FAILED' : 'SUCCESS',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: launch.success == null || launch.success == false
              ? launch.upcoming == true ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.success,
        ),
      ),
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: launch.success ?? false
              ? Theme.of(context).colorScheme.success
              : Theme.of(context).colorScheme.error,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Patch(networkSource: launch.links?.patch?.small),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextRow(texts: texts),
                  DateRow(date: launch.dateLocal),
                  IconRow(icons: icons),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
