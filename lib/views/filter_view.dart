import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/filters/filter_grid_view.dart';
import 'package:space_x_tracker/widgets/filters/filter_sub_title.dart';

class FilterView extends StatelessWidget {
  static const routeName = '/filter';

  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> statuses = [
      'Failed',
      'Success',
      'Upcoming',
    ];
    final List<String> years = List<String>.generate((DateTime.now().year-2006)+1, (int index) => (2006 + index).toString());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.background, //change your color here
        ),
        title: Text(
          'Filters',
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FilterSubTitle(text: 'Statuses'),
            FilterGridViewList(height: 82.5, texts: statuses),
            const FilterSubTitle(text: 'Years'),
            FilterGridViewList(height: 380, texts: years),
          ],
        ),
      ),
    );
  }
}
