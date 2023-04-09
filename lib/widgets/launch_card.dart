import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final Map<IconData, int> icons = {
      Icons.person: launch.crew?.length ?? 0,
      Icons.support: launch.cores?.length ?? 0,
      Icons.luggage: launch.payloads?.length ?? 0,
      Icons.directions_boat: launch.ships?.length ?? 0,
    };

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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Patch(networkSource: launch.links?.patch?.small),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextRow(
                    flightNumber: launch.flightNumber,
                    name: launch.name,
                    success: launch.success,
                  ),
                ),
                DateRow(date: launch.dateLocal),
                IconRow(icons: icons),
              ],
            )
          ],
        ),
      ),
    );
  }
}
