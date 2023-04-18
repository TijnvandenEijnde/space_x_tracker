import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_x_tracker/widgets/flash_message.dart';
import 'package:space_x_tracker/widgets/home/sorting/sorting_bottom_sheet_item.dart';

import '../../../providers/launch_provider.dart';

class SortingBottomSheet extends StatefulWidget {
  const SortingBottomSheet({Key? key}) : super(key: key);

  @override
  State<SortingBottomSheet> createState() => _SortingBottomSheetState();
}

class _SortingBottomSheetState extends State<SortingBottomSheet> {
  Map<String, bool> enabledItems = {
    'name': false,
    'flightNumber': true,
    'dateLocal': false,
    'status': false,
  };
  final Map<String, String> sortingAttributes = {
    'name': 'Name',
    'flightNumber': 'Flight Number',
    'dateLocal': 'Date',
    'status': 'Status',
  };

  void setInitialSort() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('sort')) {
      setEnabledItems(preferences.getString('sort')!);
    }
  }

  @override
  void initState() {
    super.initState();
    setInitialSort();
  }

  void toggleSort(String sort) async {
    await Provider.of<LaunchProvider>(context, listen: false)
        .sortLaunches(sort)
        .then((_) => setEnabledItems(sort))
        .catchError((_) => FlashMessage.show(
            context: context, message: 'Unable to sort data'));
  }

  void setEnabledItems(String sort) {
    setState(() =>
        enabledItems.forEach((key, value) => enabledItems[key] = key == sort));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: size.height * 0.30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Sort by',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            Divider(indent: size.width * 0.30, endIndent: size.width * 0.30),
            ...sortingAttributes.entries
                .map(
                  (attribute) => Expanded(
                    child: SortingBottomSheetItem(
                      sort: attribute.key,
                      text: attribute.value,
                      enabled: enabledItems[attribute.key] ?? false,
                      toggleSort: toggleSort,
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
