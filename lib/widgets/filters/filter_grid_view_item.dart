import 'package:flutter/material.dart';
import 'package:space_x_tracker/filter_types.dart';

class FilterGridViewItem extends StatefulWidget {
  final String text;
  final Function(String string, bool toggle, FilterTypes type) toggleFilter;
  final bool enabled;
  final FilterTypes type;

  const FilterGridViewItem({
    Key? key,
    required this.text,
    required this.toggleFilter,
    required this.enabled, required this.type,
  }) : super(key: key);

  @override
  State<FilterGridViewItem> createState() => _FilterGridViewItemState();
}

class _FilterGridViewItemState extends State<FilterGridViewItem> {
  bool enabled = false;
  bool initial = true;

  void toggleFilterItem() {
    widget.toggleFilter(widget.text, !widget.enabled, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onPrimary,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => toggleFilterItem(),
        highlightColor: Theme.of(context).colorScheme.tertiary,
        splashColor: Theme.of(context).colorScheme.tertiary,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  width: 1.5),
              color: widget.enabled == true
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: widget.enabled == true
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}
