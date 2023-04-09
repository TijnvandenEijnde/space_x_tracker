import 'package:flutter/material.dart';

class Patch extends StatelessWidget {
  final String? networkSource;

  const Patch({Key? key, required this.networkSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.175,
      height: MediaQuery.of(context).size.height * 0.09,
      child: Image.network(
        // @todo networkSource need nullcheck
        networkSource!,
        scale: 4.5,
        fit: BoxFit.contain,
      ),
    );
  }
}
