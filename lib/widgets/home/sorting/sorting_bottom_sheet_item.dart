import 'package:flutter/material.dart';

class SortingBottomSheetItem extends StatefulWidget {
  final String text;
  final String sort;
  final bool enabled;
  final Function(String sort) toggleSort;

  const SortingBottomSheetItem({
    Key? key,
    required this.text,
    required this.sort,
    required this.enabled,
    required this.toggleSort,
  }) : super(key: key);

  @override
  State<SortingBottomSheetItem> createState() => _SortingBottomSheetItemState();
}

class _SortingBottomSheetItemState extends State<SortingBottomSheetItem> {

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => widget.toggleSort(widget.sort),
      highlightColor: colorScheme.tertiary,
      splashColor: colorScheme.tertiary,
      child: Container(
        color: widget.enabled == true
            ? colorScheme.tertiary
            : Colors.transparent,
        alignment: Alignment.centerLeft,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
                color: widget.enabled == true
                    ? colorScheme.background
                    : colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
