import 'package:flutter/material.dart';

class WidgetRow extends StatelessWidget {
  final List<Widget> widgets;

  const WidgetRow({
    Key? key,
    required this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widgets
          .map(
            (Widget text) => Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.02),
              child: text,
            ),
          )
          .toList(),
    );
  }
}
