import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';

class SortingBottomSheetItem extends StatelessWidget {
  final bool enabled;
  final String text;
  final String sortingAttribute;

  const SortingBottomSheetItem({
    Key? key,
    required this.enabled,
    required this.text,
    required this.sortingAttribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Provider.of<LaunchProvider>(context, listen: false).sortLaunches(sortingAttribute),
      highlightColor: Theme.of(context).colorScheme.tertiary,
      splashColor: Theme.of(context).colorScheme.tertiary,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        height: 40,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
