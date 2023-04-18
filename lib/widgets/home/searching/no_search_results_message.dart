import 'package:flutter/material.dart';

class NoSearchResultsMessage extends StatelessWidget {
  const NoSearchResultsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: MediaQuery.of(context).size.width * 0.09,
          ),
          Text(
            'No suggestions, please adjust your search.',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}
