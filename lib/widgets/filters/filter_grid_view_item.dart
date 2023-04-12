import 'package:flutter/material.dart';

class FilterGridViewItem extends StatefulWidget {
  final String text;

  const FilterGridViewItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<FilterGridViewItem> createState() => _FilterGridViewItemState();
}

class _FilterGridViewItemState extends State<FilterGridViewItem> {
  bool enabled = false;

  void toggleSortAttribute() {
    setState(() => enabled = !enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => toggleSortAttribute(),
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
              color: enabled == true
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: enabled == true
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
