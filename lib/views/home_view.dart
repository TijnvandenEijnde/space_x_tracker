import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final List<Launch> launches = [
    Launch(
      article:
          'https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html',
      autoUpdate: true,
      capsules: ['5e9e2c5bf359189ef23b2667'],
      cores: [
        Core(
          core: '5e9e289ff359180ae23b262d',
          flight: '1',
          gridfins: false,
          legs: false,
          reused: false,
          landingAttempt: true,
          landingSuccess: false,
          landingType: 'Ocean',
          landpad: '5e9e3033383ecbb9e534e7cc',
        )
      ],
      crew: [
        Crew(id: '5ebf1a6e23a9a60006e03a7a', role: 'Joint Commander'),
        Crew(id: '5ebf1b7323a9a60006e03a7b', role: 'Commander'),
      ],
      dateLocal: DateTime.parse('2006-03-25T10:30:00+12:00'),
      datePrecision: 'hours',
      dateUnix: DateTime.fromMicrosecondsSinceEpoch(1143239400 * 1000),
      dateUtc: DateTime.parse('2006-03-24T22:30:00.000Z'),
      details: 'Engine failure at 33 seconds and loss of vehicle',
      failures: [
        Failure(
          altitude: 300,
          reason: 'merlin engine failure',
          timeInSeconds: 33,
        ),
      ],
      fairings: [
        Fairing(
          reused: false,
          recovered: false,
          recoveryAttempt: false,
          ships: [
            '5ea6ed2f080df4000697c90b',
            '5ea6ed2f080df4000697c910',
          ],
        )
      ],
      flightNumber: '1',
      id: '5eb87cd9ffd86e000604b32a',
      launchLibraryId: 'f31702e8-6353-4c9a-932c-5bd104717500',
      launchpad: '5e9e4502f5090995de566f86',
      name: 'FalconSat',
      net: false,
      patch: 'https://images2.imgbox.com/94/f2/NN6Ph45r_o.png',
      payloads: ['5eb0e4b5b6c3bb0006eeb1e1'],
      rocket: '5e9d0d95eda69955f709d1eb',
      ships: [
        '5ea6ed2f080df4000697c90b',
        '5ea6ed2f080df4000697c910',
      ],
      staticFireDateUnix: DateTime.fromMicrosecondsSinceEpoch(
        1142553600 * 1000,
      ),
      staticFireDateUtc: DateTime.parse('2006-03-17T00:00:00.000Z'),
      success: false,
      tbd: false,
      upcoming: false,
      webcast: 'https://www.youtube.com/watch?v=0a_00nJ_Y88',
      window: '900',
    )
  ];

  @override
  Widget build(BuildContext context) {
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
                side: BorderSide(color: Theme.of(context).colorScheme.error)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  CircleAvatar(
                    radius: 36.5,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      radius: 35.0,
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
                                      ? Colors.green
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
