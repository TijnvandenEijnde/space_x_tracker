import 'package:flutter/material.dart';

class FilterGridViewItem extends StatefulWidget {
  final String text;
  final Function(String string, bool toggle) toggleFilter;
  final bool enabled;

  const FilterGridViewItem({
    Key? key,
    required this.text,
    required this.toggleFilter,
    required this.enabled,
  }) : super(key: key);

  @override
  State<FilterGridViewItem> createState() => _FilterGridViewItemState();
}

class _FilterGridViewItemState extends State<FilterGridViewItem> {
  bool enabled = false;
  bool initial = true;

  void toggleFilterItem() {
    widget.toggleFilter(widget.text, !widget.enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
