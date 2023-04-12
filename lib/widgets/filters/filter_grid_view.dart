import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/filters/filter_grid_view_item.dart';

class FilterGridViewList extends StatelessWidget {
  final double height;
  final List<String> texts;

  const FilterGridViewList({
    Key? key,
    required this.texts, required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(5)),
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          childAspectRatio: 2.6,
          mainAxisSpacing: 20,
        ),
        shrinkWrap: true,
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return FilterGridViewItem(text: texts[index]);
        },
      ),
    );
  }
}
