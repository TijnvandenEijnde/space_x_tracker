import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:space_x_tracker/providers/models/launch_details_arguments.dart';
import 'package:space_x_tracker/providers/models/rocket.dart';
import 'package:space_x_tracker/providers/rocket_provider.dart';

import '../widgets/flash_message.dart';

class LaunchDetailsView extends StatefulWidget {
  final http.Client client;

  const LaunchDetailsView({
    Key? key,
    required this.client,
  }) : super(key: key);

  static const routeName = '/launch-details';

  @override
  State<LaunchDetailsView> createState() => _LaunchDetailsViewState();
}

class _LaunchDetailsViewState extends State<LaunchDetailsView> {
  Rocket? _rocket;
  Map<String, dynamic>? _rocketMeasurements;
  final Map<String, String> detailsText = {
    "height": "Height",
    "diameter": "Diameter",
    "mass": "Mass",
    "stages": "Stages",
    "boosters": "Boosters",
    "successRatePercentage": "Success",
  };

  Future<void> _getRocket() async {
    final LaunchDetailsArguments arguments =
        ModalRoute.of(context)!.settings.arguments as LaunchDetailsArguments;

    await Provider.of<RocketProvider>(context, listen: false)
        .fetchRocket(widget.client, arguments.rocketId)
        .then((rocket) => setState(() {
          _rocket = rocket;
          _rocketMeasurements = rocket.rocketMeasurements;
    }));
  }

  @override
  void didChangeDependencies() {
    _getRocket();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      backgroundColor: colorScheme.tertiary,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
        title: Text(
          'Launch details',
          style: TextStyle(
            color: colorScheme.onPrimary,
          ),
        ),
        backgroundColor: colorScheme.primary,
      ),
      body: _rocket == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Image.network(_rocket!.flickrImages!.first),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.28),
                    height: size.height * 0.72,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25)),
                        color: colorScheme.onPrimary),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _rocket?.name ?? 'Unnamed rocket',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _rocket?.description ?? 'No description',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      _rocket?.launchPrice ?? 'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text('Price per launch',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                  ],
                                ),
                                Text(
                                  'Inactive',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 20,
                                childAspectRatio: 1.5,
                                mainAxisSpacing: 20,
                              ),
                              shrinkWrap: true,
                              itemCount: detailsText.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    // horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Text(detailsText.values.elementAt(index),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Text(_rocketMeasurements![detailsText.keys.elementAt(index)],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
