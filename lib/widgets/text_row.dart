import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  final List<Text> texts;

  const TextRow({
    Key? key,
    required this.texts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: texts
          .map(
            (Text text) => Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.02),
              child: text,
            ),
          )
          .toList(),
    );
  }
}
