import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_x_tracker/filter_types.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';
import 'package:space_x_tracker/widgets/filters/filter_grid_view.dart';
import 'package:space_x_tracker/widgets/filters/filter_sub_title.dart';

class FilterView extends StatefulWidget {
  static const routeName = '/filter';

  const FilterView({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  Map<String, List<String>> filters = {};
  Map<String, bool> enabledItems = {};
  final List<String> statuses = [
    'Failed',
    'Success',
    'Upcoming',
  ];
  final List<String> years = List<String>.generate(
      (DateTime.now().year - 2006) + 1,
      (int index) => (2006 + index).toString());

  void setInitialFilters() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('filters')) {
      setState(() {
        final sharedFilters = jsonDecode(preferences.getString('filters')!);

        for (var key in sharedFilters.keys) {
          for (var value in sharedFilters[key]) {
            if (filters[key] == null) {
              filters[key] = [];
            }
            filters[key]?.add(value);
          }
        }

        if (filters.containsKey('years')) {
          for (var element in filters['years']!) {
            enabledItems[element] = true;
          }
        }

        if (filters.containsKey('statuses')) {
          for (var element in filters['statuses']!) {
            enabledItems[element] = true;
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setInitialFilters();
  }

  void toggleFilter(String filter, bool toggle, FilterTypes type) {
    if (toggle == true) {
      setState(() {
        if (filters[type.name] == null) {
          filters[type.name] = [];
        }

        filters[type.name]?.add(filter.toLowerCase());
        enabledItems[filter.toLowerCase()] = true;
      });
    } else {
      setState(() {
        filters[type.name]?.remove(filter.toLowerCase());

        if (filters[type.name]?.isEmpty == true) {
          filters.remove(type.name);
        }

        enabledItems[filter.toLowerCase()] = false;
      });
    }
  }

  void discardFilters() {
    setState(() {
      enabledItems.clear();
      filters.clear();
    });

    Provider.of<LaunchProvider>(context, listen: false).filterLaunches({});
  }

  void applyFilters() async {
    await Provider.of<LaunchProvider>(context, listen: false)
        .filterLaunches(filters)
        .then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              Theme.of(context).colorScheme.onPrimary, //change your color here
        ),
        title: Text(
          'Filters',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          TextButton(
            onPressed: () => discardFilters(),
            child: Text(
              'Discard',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          TextButton(
            onPressed: () => applyFilters(),
            child: Text(
              'Apply',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FilterSubTitle(text: 'Statuses'),
            FilterGridViewList(
              height: 82.5,
              texts: statuses,
              toggleFilter: toggleFilter,
              enabledItems: enabledItems,
              type: FilterTypes.statuses,
            ),
            const FilterSubTitle(text: 'Years'),
            FilterGridViewList(
              height: 380,
              texts: years,
              toggleFilter: toggleFilter,
              enabledItems: enabledItems,
              type: FilterTypes.years,
            ),
          ],
        ),
      ),
    );
  }
}
