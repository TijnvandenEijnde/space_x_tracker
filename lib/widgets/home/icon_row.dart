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

    List<Widget> iconList = icons.entries.map((icon) {
      return Padding(
        padding: EdgeInsets.only(right: size.width * 0.025),
        child: IconRowItem(count: icon.value, icon: icon.key),
      );
    }).toList();

    if (widget != null) {
      iconList.insert(
        0,
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.025),
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
