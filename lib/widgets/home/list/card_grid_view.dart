import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:space_x_tracker/widgets/home/card/launch_card.dart';

class CardGridView extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  final bool fittedBox;
  final List<Launch> launches;

  const CardGridView({
    Key? key,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.launches,
    this.fittedBox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 0,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: 0,
      ),
      itemCount: launches.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: fittedBox == true
            ? FittedBox(
                fit: BoxFit.fitWidth,
                child: LaunchCard(launch: launches[index]),
              )
            : LaunchCard(launch: launches[index]),
      ),
    );
  }
}
