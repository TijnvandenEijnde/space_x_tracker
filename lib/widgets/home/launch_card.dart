import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/providers/models/launch_details_arguments.dart';
import 'package:space_x_tracker/views/rocket_view.dart';
import 'package:space_x_tracker/widgets/home/icon_row.dart';
import 'package:space_x_tracker/widgets/home/patch.dart';
import 'package:space_x_tracker/widgets/home/status_text.dart';
import 'package:space_x_tracker/widgets/home/widget_row.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;

  const LaunchCard({
    Key? key,
    required this.launch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;
    final String status = launch.status;
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
        width: orientation == Orientation.portrait
            ? size.width * 0.60
            : size.width * 0.25,
        child: Text(
          launch.name == null ? 'Unnamed' : launch.name!,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      )
    ];
    final Map<String, Color> statusColors = {
      'FAILED': colorScheme.error,
      'SUCCESS': colorScheme.success,
      'UPCOMING': colorScheme.tertiary,
    };

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(RocketView.routeName,
          arguments: LaunchDetailsArguments(launch.rocket!)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: statusColors[status]!,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                child: SizedBox(
                  width: 60,
                  child: Patch(
                    key: ValueKey(
                      'patch-${launch.id}',
                    ),
                    networkSource: launch.links?.patch?.small,
                  ),
                ),
              ),
              orientation == Orientation.portrait
                  ? SizedBox(width: size.width * 0.030)
                  : const SizedBox.shrink(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetRow(
                    widgets: widgetsRowTwo,
                  ),
                  WidgetRow(
                    widgets: widgetsRowOne,
                  ),
                  IconRow(
                    icons: icons,
                    widget: StatusText(
                      status: status,
                      color: statusColors[status]!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
