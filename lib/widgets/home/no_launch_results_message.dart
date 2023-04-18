import 'package:flutter/material.dart';

class NoLaunchResultsMessage extends StatelessWidget {
  final String subText;

  const NoLaunchResultsMessage({
    Key? key,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

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
            Text(
              'No results found.',
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                subText,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
