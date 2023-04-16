import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/card_list_view.dart';
import 'package:space_x_tracker/widgets/no_launch_results_message.dart';
import 'package:space_x_tracker/widgets/searching/no_search_results_message.dart';

class LaunchSearchDelegate extends SearchDelegate {
  final List<Launch> launches;
  List<Launch> results = [];

  LaunchSearchDelegate({required this.launches});

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) =>
      Consumer<LaunchProvider>(builder: (context, launch, child) {
        return results.isEmpty == true
            ? const NoLaunchResultsMessage(
                subText: 'There are no launches matching this search.')
            : CardViewList(
                launches: results,
              );
      });

  @override
  Widget buildSuggestions(BuildContext context) {
    results = launches.where((Launch launch) {
      final resultName = launch.name?.toLowerCase() ?? '';
      final resultFlightNumber =
          launch.flightNumber == null ? '#' : '#${launch.flightNumber}';
      final resultNameLocalDate = launch.dateLocal == null
          ? 'no date'
          : DateFormat('MMM d y, h:mm:ss a')
              .format(launch.dateLocal!)
              .toLowerCase();

      final String input = query.toLowerCase();

      return resultName.contains(input) ||
          resultFlightNumber.contains(input) ||
          resultNameLocalDate.contains(input);
    }).toList();

    return Consumer<LaunchProvider>(builder: (context, launch, child) {
      return results.isEmpty == true && query != ''
          ? const NoSearchResultsMessage()
          : CardViewList(
              launches: results,
            );
    });
  }
}
