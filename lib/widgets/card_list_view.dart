import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/models/launch.dart';

import 'launch_card.dart';

class CardViewList extends StatelessWidget {
  final List<Launch> launches;

  const CardViewList({Key? key, required this.launches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: launches.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: LaunchCard(launch: launches[index]),
      ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
