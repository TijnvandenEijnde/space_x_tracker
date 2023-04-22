import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/models/launch.dart';

import 'launch_card.dart';

class CardViewList extends StatelessWidget {
  final List<Launch> launches;

  const CardViewList({
    Key? key,
    required this.launches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.portrait ? 1 : size.width > 800 ? 2 : 1,
        crossAxisSpacing: 0,
        childAspectRatio: orientation == Orientation.portrait ? 4 : 4,
        mainAxisSpacing: 0,
      ),
      itemCount: launches.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: LaunchCard(launch: launches[index]),
      ),
    );
  }
}
