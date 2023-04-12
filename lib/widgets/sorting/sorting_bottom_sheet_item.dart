import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/launch_provider.dart';

class SortingBottomSheetItem extends StatefulWidget {
  final String text;
  final String sortingAttribute;

  const SortingBottomSheetItem({
    Key? key,
    required this.text,
    required this.sortingAttribute,
  }) : super(key: key);

  @override
  State<SortingBottomSheetItem> createState() => _SortingBottomSheetItemState();
}

class _SortingBottomSheetItemState extends State<SortingBottomSheetItem> {
  bool enabled = false;

  void toggleSortAttribute() {
    setState(() => enabled = !enabled);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<LaunchProvider>(context, listen: false)
            .sortLaunches(widget.sortingAttribute);
        toggleSortAttribute();
      },
      highlightColor: Theme.of(context).colorScheme.tertiary,
      splashColor: Theme.of(context).colorScheme.tertiary,
      child: Container(
        color: enabled == true ? Theme.of(context).colorScheme.tertiary : Colors.transparent,
        alignment: Alignment.centerLeft,
        height: 40,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
                color: enabled == true ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
