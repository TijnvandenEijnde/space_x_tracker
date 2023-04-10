import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/models/launch.dart';
import 'package:http/http.dart' as http;

import 'launch_card.dart';

class CardViewList extends StatelessWidget {
  final http.Client client;
  final List<Launch> launches;

  const CardViewList({
    Key? key,
    required this.launches,
    required this.client,
  }) : super(key: key);

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
