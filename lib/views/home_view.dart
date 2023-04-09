import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';
import 'package:space_x_tracker/providers/launchProvider.dart';
import 'package:space_x_tracker/providers/models/core.dart';
import 'package:space_x_tracker/providers/models/crew.dart';
import 'package:space_x_tracker/providers/models/failure.dart';
import 'package:space_x_tracker/providers/models/fairing.dart';
import 'package:space_x_tracker/providers/models/launch.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Launch> _launches = [];

  Future<void> _getLaunches() async {
    Provider.of<LaunchProvider>(context, listen: false).fetchLaunches().then(
        (_) => _launches =
            Provider.of<LaunchProvider>(context, listen: false).allLaunches);
  }

  @override
  void initState() {
    _getLaunches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _launches = Provider.of<LaunchProvider>(context, listen: true).allLaunches;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Launches',
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.separated(
        itemCount: launches.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: launches[index].success
                    ? Theme.of(context).colorScheme.success
                    : Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.095,
                    backgroundColor: launches[index].success
                        ? Theme.of(context).colorScheme.success
                        : Theme.of(context).colorScheme.error,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      radius: MediaQuery.of(context).size.width * 0.090,
                      child: SizedBox.fromSize(
                        child: Image.network(
                          launches[index].patch,
                          scale: 4.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '#${launches[index].flightNumber}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(launches[index].name),
                            Text(
                              launches[index].success ? 'SUCCESS' : 'FAILED',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: launches[index].success
                                      ? Theme.of(context).colorScheme.success
                                      : Theme.of(context).colorScheme.error),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat('MMM d y, h:mm:ss a')
                                .format(launches[index].dateLocal),
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Text(launches[index].crew?.isEmpty == true
                                        ? '0'
                                        : launches[index]
                                            .crew!
                                            .length
                                            .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.support,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Text(launches[index].cores.isEmpty == true
                                        ? '0'
                                        : launches[index]
                                            .cores
                                            .length
                                            .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.luggage,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Text(launches[index].payloads?.isEmpty ==
                                            true
                                        ? '0'
                                        : launches[index]
                                            .payloads!
                                            .length
                                            .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.directions_boat,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Text(launches[index].ships?.isEmpty == true
                                        ? '0'
                                        : launches[index]
                                            .ships!
                                            .length
                                            .toString()),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
