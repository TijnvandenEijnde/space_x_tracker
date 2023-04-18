import 'package:flutter/material.dart';

class WidgetRow extends StatelessWidget {
  final List<Widget> widgets;
  final double width;

  const WidgetRow({
    Key? key,
    required this.widgets,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: widgets
            .map(
              (Widget text) => Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02),
                child: SizedBox(child: text),
              ),
            )
            .toList(),
      ),
    );
  }
}
