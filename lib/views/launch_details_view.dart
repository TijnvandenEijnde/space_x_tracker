import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:space_x_tracker/custom_color_scheme.dart';
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
    "payloads": "Payloads",
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
    Map<IconData, Color> statusColors = {
      Icons.cancel: colorScheme.error,
      Icons.check_circle: colorScheme.success,
      Icons.help: colorScheme.tertiary,
    };

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: _rocket == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.4 - 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_rocket!.flickrImages!.first),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: size.width * 0.9,
                            height: 80,
                            decoration: BoxDecoration(
                                color: colorScheme.background,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 5),
                                      blurRadius: 75,
                                      color:
                                          colorScheme.shadow.withOpacity(0.2))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _rocket?.status ?? Icons.help,
                                      size: 27,
                                      color: statusColors[_rocket?.status] ?? colorScheme.tertiary,
                                    ), //check_circle
                                    Text(_rocket?.statusText ?? 'Unknown',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${_rocket?.successRatePct.toString()}%' ??
                                          'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text('Success rate',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _rocket?.launchPrice ?? 'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text('Launch cost',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SafeArea(
                            child: BackButton(
                          color: colorScheme.background,
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _rocket?.description ?? 'No description',
                            style: Theme.of(context).textTheme.bodyMedium,
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
                                  // crossAxisAlignment:
                                  // CrossAxisAlignment.start,
                                  children: [
                                    Text(detailsText.values.elementAt(index),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    Text(
                                        _rocketMeasurements![
                                            detailsText.keys.elementAt(index)],
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
                ],
              ),
            ),
    );
  }
}
