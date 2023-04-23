import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/home/card_list_view_responsive_layout.dart';

import 'launch_card.dart';

class CardViewList extends StatelessWidget {
  final List<Launch> launches;

  const CardViewList({
    Key? key,
    required this.launches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListViewResponsiveLayout(
      smallLandscape: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          childAspectRatio: 6,
          mainAxisSpacing: 0,
        ),
        itemCount: launches.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: LaunchCard(launch: launches[index]),
        ),
      ),
      smallPortrait: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          childAspectRatio: 4,
          mainAxisSpacing: 0,
        ),
        itemCount: launches.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: LaunchCard(launch: launches[index]),
        ),
      ),
      mediumLandscape: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 4,
          mainAxisSpacing: 0,
        ),
        itemCount: launches.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: LaunchCard(launch: launches[index]),
        ),
      ),
      mediumPortrait: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 6,
          mainAxisSpacing: 0,
        ),
        itemCount: launches.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: LaunchCard(launch: launches[index]),
          ),
        ),
      ),
      large: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 8,
          mainAxisSpacing: 0,
        ),
        itemCount: launches.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: LaunchCard(launch: launches[index]),
        ),
      ),
    );
  }
}
