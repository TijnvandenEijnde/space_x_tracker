import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Patch extends StatelessWidget {
  final String? networkSource;

  const Patch({
    Key? key,
    required this.networkSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return networkSource == null
        ? Image.asset(
            'assets/placeholders/rocket-placeholder-small.png',
          )
        : CachedNetworkImage(
            imageUrl: networkSource!,
            placeholder: (context, url) => const Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/placeholders/rocket-placeholder-small.png',
            ),
          );
  }
}
