import 'package:flutter/material.dart';

class NoLaunchResultsMessage extends StatelessWidget {
  final String subText;

  const NoLaunchResultsMessage({
    Key? key,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: MediaQuery.of(context).size.width * 0.3,
            ),
            Text('No results found.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(subText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
            )
          ],
        ),
      ),
    );
  }
}
