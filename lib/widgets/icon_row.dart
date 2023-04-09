import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/icon_row_item.dart';

class IconRow extends StatelessWidget {
  final Map<IconData, int> icons;

  const IconRow({Key? key, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: icons.entries.map((icon) {
                return IconRowItem(count: icon.value, icon: icon.key);
              }).toList(),
          ),
        )
      ],
    );
  }
}
