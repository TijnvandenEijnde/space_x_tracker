import 'package:flutter/material.dart';

class RocketImageContainer extends StatelessWidget {
  final ImageProvider imageProvider;

  const RocketImageContainer({
    Key? key,
    required this.imageProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;

    return Container(
      height:
          size.height * (orientation == Orientation.portrait ? 0.4 : 1.5) - 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
        ),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
