import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/sorting/sorting_bottom_sheet_item.dart';

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
        // @TODO use MediaQueries
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
            // @TODO might be an unnecessary column
            Column(
              // @TODO what if we select multiple items they will all be orange, would a provider help here?
              children: sortingAttributes.entries
                  .map(
                    (attribute) => SortingBottomSheetItem(
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
