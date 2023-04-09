import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/icon_row_item.dart';

class IconRow extends StatelessWidget {
  final Map<IconData, String> icons;

  const IconRow({Key? key, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Row(
            children: icons.entries.map((icon) {
                return Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.035),
                  child: IconRowItem(count: icon.value, icon: icon.key),
                );
              }).toList(),
          ),
        )
      ],
    );
  }
}
