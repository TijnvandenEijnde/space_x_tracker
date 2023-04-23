import 'package:flutter/material.dart';

class NoSearchResultsMessage extends StatelessWidget {
  const NoSearchResultsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: orientation == Orientation.portrait
                ? size.width * 0.09
                : size.height * 0.09,
          ),
          Text(
            'No suggestions, please adjust your search.',
            style: textTheme.labelLarge
                ?.copyWith(color: colorScheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}
