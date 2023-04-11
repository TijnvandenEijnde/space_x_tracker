import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/sorting_bottom_sheet_item.dart';

class SortingBottomSheet extends StatelessWidget {
  const SortingBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> sortingAttributes = {
      'name': 'Name',
      'flightNumber': 'Flight Number',
      'dateLocal': 'Date',
      'status': 'Status',
    };

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Sort by',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            const Divider(indent: 100, endIndent: 100),
            Column(
              children: sortingAttributes.entries
                  .map(
                    (attribute) => SortingBottomSheetItem(
                      enabled: false,
                      sortingAttribute: attribute.key,
                      text: attribute.value,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
