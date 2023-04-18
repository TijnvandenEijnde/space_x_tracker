import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/rocket/rocket_image_container.dart';

class RocketCoverImage extends StatelessWidget {
  final String? imageUrl;

  const RocketCoverImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return imageUrl == null
        ? const RocketImageContainer(
            imageProvider: AssetImage(
              'assets/placeholders/rocket-placeholder-large.png',
            ),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            imageBuilder: (context, imageProvider) =>
                RocketImageContainer(imageProvider: imageProvider),
            placeholder: (context, url) => SizedBox(
              height: size.height * (orientation == Orientation.portrait ? 0.4 : 1.5) - 50,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => const RocketImageContainer(
              imageProvider: AssetImage(
                'assets/placeholders/rocket-placeholder-large.png',
              ),
            ),
          );
  }
}
