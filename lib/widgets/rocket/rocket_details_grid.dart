import 'package:flutter/material.dart';
import 'package:space_x_tracker/providers/models/rocket.dart';

class RocketDetailsGrid extends StatelessWidget {
  final Rocket? rocket;
  final Map<String, dynamic>? rocketDetails;

  const RocketDetailsGrid({
    Key? key,
    required this.rocket,
    required this.rocketDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Map<String, String> detailsText = {
      'height': 'Height',
      'diameter': 'Diameter',
      'mass': 'Mass',
      'stages': 'Stages',
      'boosters': 'Boosters',
      'payloads': 'Payloads',
    };

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rocket?.name ?? 'Unnamed rocket',
              style: textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              rocket?.description ?? 'No description',
              style: textTheme.bodyMedium,
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
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
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    // crossAxisAlignment:
                    // CrossAxisAlignment.start,
                    children: [
                      Text(
                        detailsText.values.elementAt(index),
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        rocket
                            ?.rocketDetails[detailsText.keys.elementAt(index)],
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
