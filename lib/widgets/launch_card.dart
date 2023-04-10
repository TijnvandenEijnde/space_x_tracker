import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/status_text.dart';
import 'package:space_x_tracker/widgets/icon_row.dart';
import 'package:space_x_tracker/widgets/patch.dart';
import 'package:space_x_tracker/widgets/widget_row.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;

  const LaunchCard({
    Key? key,
    required this.launch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool success = launch.success == null || launch.success == false;
    final Map<IconData, String> icons = {
      Icons.person: launch.crew?.length.toString() ?? '0',
      Icons.support: launch.cores?.length.toString() ?? '0',
      Icons.luggage: launch.payloads?.length.toString() ?? '0',
      Icons.directions_boat: launch.ships?.length.toString() ?? '0',
    };
    final List<Text> widgetsRowOne = [
      Text(
        '#${launch.flightNumber ?? '-'}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        launch.dateLocal == null
            ? 'No date'
            : DateFormat('MMM d y, h:mm:ss a').format(launch.dateLocal!),
      ),
    ];
    final List<SizedBox> widgetsRowTwo = [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        child: Text(
          launch.name == null ? 'Unnamed' : launch.name!,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      )
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: success
              ? launch.upcoming == true
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.success,
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
              child: Patch(
                  key: ValueKey('patch-${launch.id}'),
                  networkSource: launch.links?.patch?.small),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.030),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.66,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WidgetRow(
                      widgets: widgetsRowTwo,
                      width: MediaQuery.of(context).size.width * 0.70),
                  WidgetRow(
                      widgets: widgetsRowOne,
                      width: MediaQuery.of(context).size.width * 0.70),
                  IconRow(
                    icons: icons,
                    widget: StatusText(
                      success: success,
                      upcoming: launch.upcoming ?? false,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
