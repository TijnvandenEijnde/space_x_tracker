import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/home/list/card_grid_view.dart';
import 'package:space_x_tracker/widgets/home/list/card_list_view_responsive_layout.dart';

class CardList extends StatelessWidget {
  final List<Launch> launches;

  const CardList({
    Key? key,
    required this.launches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListViewResponsiveLayout(
      smallLandscape: CardGridView(
        crossAxisCount: 1,
        childAspectRatio: 6,
        launches: launches,
      ),
      smallPortrait: CardGridView(
        crossAxisCount: 1,
        childAspectRatio: 4,
        launches: launches,
      ),
      mediumLandscape: CardGridView(
        crossAxisCount: 2,
        childAspectRatio: 4,
        launches: launches,
      ),
      mediumPortrait: CardGridView(
        fittedBox: true,
        crossAxisCount: 2,
        childAspectRatio: 6,
        launches: launches,
      ),
      large: CardGridView(
        crossAxisCount: 2,
        childAspectRatio: 8,
        launches: launches,
      ),
    );
  }
}
