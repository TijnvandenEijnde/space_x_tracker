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
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.175,
      height: size.height * 0.09,
      child: networkSource == null
          ? Image.asset(
              'assets/placeholders/rocket-placeholder-small.png',
            )
          : CachedNetworkImage(
              imageUrl: networkSource!,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/placeholders/rocket-placeholder-small.png',
              ),
            ),
    );
  }
}
