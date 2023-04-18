import 'package:flutter/material.dart';
import 'package:space_x_tracker/widgets/home/icon_row_item.dart';

class IconRow extends StatelessWidget {
  final Map<IconData, String> icons;
  final Widget? widget;

  const IconRow({
    Key? key,
    required this.icons,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double padding =
        orientation == Orientation.portrait ? size.width * 0.025 : 7.5;

    List<Widget> iconList = icons.entries.map((icon) {
      return Padding(
        padding: EdgeInsets.only(right: padding),
        child: IconRowItem(count: icon.value, icon: icon.key),
      );
    }).toList();

    if (widget != null) {
      iconList.insert(
        0,
        Padding(
          padding: EdgeInsets.only(right: padding),
          child: widget!,
        ),
      );
    }

    return Row(
      children: [
        SizedBox(
          child: Row(
            children: iconList,
          ),
        )
      ],
    );
  }
}
