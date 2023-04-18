import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/filter/filter_types.dart';

class FilterGridViewItem extends StatefulWidget {
  final String text;
  final Function(String filter, bool enabled, FilterTypes type) toggleFilter;
  final bool enabled;
  final FilterTypes type;

  const FilterGridViewItem({
    Key? key,
    required this.text,
    required this.toggleFilter,
    required this.enabled,
    required this.type,
  }) : super(key: key);

  @override
  State<FilterGridViewItem> createState() => _FilterGridViewItemState();
}

class _FilterGridViewItemState extends State<FilterGridViewItem> {
  void toggleFilterItem() {
    widget.toggleFilter(widget.text, !widget.enabled, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.onPrimary,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => toggleFilterItem(),
        highlightColor: colorScheme.tertiary,
        splashColor: colorScheme.tertiary,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme.surfaceVariant,
                width: 1.5,
              ),
              color: widget.enabled == true
                  ? colorScheme.tertiary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: widget.enabled == true
                    ? colorScheme.onPrimary
                    : colorScheme.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}
